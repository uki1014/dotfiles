#!/usr/bin/env python3
"""herdr のワークスペース構成を定義ファイルから作る・現状と突き合わせる。

定義はクライアントのリポジトリ名を含むので、公開の dotfiles ではなく非公開の agent-config に置く。

使い方:
  workspaces.py apply [--dry-run] [--only NAME]...  定義にあって未作成のワークスペースを作る
  workspaces.py check [--only NAME]...              定義と herdr の保存状態の差分を出す(差分があれば終了コード 1)
"""
import argparse
import json
import os
import subprocess
import sys

DEFINITION = os.environ.get("HERDR_WORKSPACES", os.path.expanduser("~/agent-config/herdr/workspaces.json"))
SESSION = os.path.expanduser("~/.config/herdr/session.json")
RATIO_TOLERANCE = 0.01
# session.json は左右分割を Horizontal、上下分割を Vertical と書く
SESSION_DIRECTION = {"Horizontal": "right", "Vertical": "down"}


def expand(path):
    return os.path.normpath(os.path.expanduser(path))


def shorten(path):
    home = os.path.expanduser("~")
    return "~" + path[len(home):] if path == home or path.startswith(home + "/") else path


def load_definition():
    with open(DEFINITION) as f:
        return json.load(f)


def herdr(*args):
    out = subprocess.run(["herdr", *args], capture_output=True, text=True)
    if out.returncode != 0:
        raise RuntimeError(f"herdr {' '.join(args)}: {out.stderr.strip()}")
    # pane run のように結果を返さないコマンドは標準出力が空になる
    return json.loads(out.stdout)["result"] if out.stdout.strip() else {}


def slots(node):
    if isinstance(node, str):
        return [node]
    return slots(node[2]) + slots(node[3])


# 定義の木を、各スロットに作業フォルダを入れた形に展開する
def resolve(workspace, layouts):
    pane_cwds = workspace.get("panes", {})

    def walk(node):
        if isinstance(node, str):
            return expand(pane_cwds.get(node, workspace["cwd"]))
        direction, ratio, first, second = node
        return [direction, ratio, walk(first), walk(second)]

    return walk(layouts[workspace["layout"]])


def first_leaf(tree):
    return tree if isinstance(tree, str) else first_leaf(tree[2])


def prepare_dirs(definition, cwds, dry_run):
    repos = {expand(k): v for k, v in definition.get("repos", {}).items()}
    worktrees = {expand(k): expand(v) for k, v in definition.get("worktrees", {}).items()}
    ok = True
    for cwd in cwds:
        if os.path.isdir(cwd):
            continue
        # サブディレクトリ指定(stride/infra/... など)はリポジトリ本体を用意すれば揃う
        root = next((p for p in list(repos) + list(worktrees) if cwd == p or cwd.startswith(p + "/")), None)
        if root is None:
            print(f"  missing {shorten(cwd)}: repos にも worktrees にも無いので作れない")
            ok = False
            continue
        if root in worktrees:
            main = worktrees[root]
            if not os.path.isdir(main):
                if main not in repos:
                    print(f"  missing {shorten(main)}: worktree の元リポジトリが repos に無い")
                    ok = False
                    continue
                run_step(dry_run, ["git", "clone", repos[main], main])
            # 同じブランチは複数の worktree でチェックアウトできないので detached で作る
            run_step(dry_run, ["git", "-C", main, "worktree", "add", "--detach", root])
        else:
            run_step(dry_run, ["git", "clone", repos[root], root])
        if not dry_run and not os.path.isdir(cwd):
            print(f"  missing {shorten(cwd)}: 用意したリポジトリの中に無い")
            ok = False
    return ok


def run_step(dry_run, cmd):
    print(f"  {'would run' if dry_run else 'run'}: {' '.join(cmd)}")
    if not dry_run:
        subprocess.run(cmd, check=True)


def build(tree, pane_id, panes_by_path, path=()):
    if isinstance(tree, str):
        panes_by_path[path] = pane_id
        return
    direction, ratio, first, second = tree
    new = herdr("pane", "split", pane_id, "--direction", direction, "--ratio", str(ratio),
                "--cwd", first_leaf(second), "--no-focus")["pane"]["pane_id"]
    build(first, pane_id, panes_by_path, path + (0,))
    build(second, new, panes_by_path, path + (1,))


def slot_paths(node, path=()):
    if isinstance(node, str):
        return {node: path}
    paths = slot_paths(node[2], path + (0,))
    paths.update(slot_paths(node[3], path + (1,)))
    return paths


def live_labels():
    return {w["label"]: w["workspace_id"] for w in herdr("workspace", "list")["workspaces"]}


def selected(definition, only):
    workspaces = definition["workspaces"]
    if only:
        unknown = set(only) - {w["name"] for w in workspaces}
        if unknown:
            sys.exit(f"定義に無いワークスペース: {', '.join(sorted(unknown))}")
        workspaces = [w for w in workspaces if w["name"] in only]
    return workspaces


def cmd_apply(args):
    definition = load_definition()
    layouts = definition["layouts"]
    existing = live_labels()
    failed = False
    for workspace in selected(definition, args.only):
        name = workspace["name"]
        if name in existing:
            print(f"{name}: already exists. Skip.")
            continue
        tree = resolve(workspace, layouts)
        cwds = sorted(set(slots(tree)))
        print(f"{name}: {'would create' if args.dry_run else 'create'} ({workspace['layout']})")
        if not prepare_dirs(definition, cwds, args.dry_run):
            failed = True
            continue
        if args.dry_run:
            continue
        created = herdr("workspace", "create", "--cwd", first_leaf(tree), "--label", name, "--no-focus")
        panes = {}
        build(tree, created["root_pane"]["pane_id"], panes)
        paths = slot_paths(layouts[workspace["layout"]])
        for slot in workspace.get("agents", ["main"]):
            pane = panes[paths[slot]]
            herdr("pane", "run", pane, definition.get("agent_command", "claude"))
            print(f"  started agent in {slot} ({pane})")
    return 1 if failed else 0


# session.json の木を定義と同じ [direction, ratio, first, second] / cwd の形にする
def session_tree(node, panes):
    if "Pane" in node:
        return expand(panes[str(node["Pane"])]["cwd"])
    split = node["Split"]
    return [SESSION_DIRECTION[split["direction"]], split["ratio"],
            session_tree(split["first"], panes), session_tree(split["second"], panes)]


def diff_tree(expected, actual, where, out):
    label = where or "全体"
    if isinstance(expected, str) or isinstance(actual, str):
        if isinstance(expected, str) and isinstance(actual, str):
            if expected != actual:
                out.append(f"{label}: cwd {shorten(actual)} (定義は {shorten(expected)})")
        else:
            out.append(f"{label}: 分割の形が違う")
        return
    if expected[0] != actual[0]:
        out.append(f"{label}: 分割の向き {actual[0]} (定義は {expected[0]})")
        return
    if abs(expected[1] - actual[1]) > RATIO_TOLERANCE:
        out.append(f"{label}: 比率 {actual[1]:.3f} (定義は {expected[1]})")
    first, second = ("左", "右") if expected[0] == "right" else ("上", "下")
    diff_tree(expected[2], actual[2], f"{where}{first}", out)
    diff_tree(expected[3], actual[3], f"{where}{second}", out)


def cmd_check(args):
    definition = load_definition()
    with open(SESSION) as f:
        session = {w["id"]: w for w in json.load(f)["workspaces"]}
    labels = live_labels()
    wanted = selected(definition, args.only)
    differences = 0
    for workspace in wanted:
        name = workspace["name"]
        if name not in labels:
            print(f"{name}: herdr に無い")
            differences += 1
            continue
        saved = session.get(labels[name])
        if saved is None:
            print(f"{name}: session.json にまだ保存されていない")
            differences += 1
            continue
        tab = saved["tabs"][0]
        out = []
        if len(saved["tabs"]) > 1:
            out.append(f"タブが {len(saved['tabs'])} 個ある(定義は 1 個)")
        diff_tree(resolve(workspace, definition["layouts"]), session_tree(tab["layout"], tab["panes"]), "", out)
        if out:
            differences += 1
            print(f"{name}:")
            for line in out:
                print(f"  {line}")
    if not args.only:
        defined = {w["name"] for w in definition["workspaces"]}
        for label in labels:
            if label not in defined:
                print(f"{label}: 定義に無い")
                differences += 1
    print(f"--- 差分のあるワークスペース: {differences}")
    return 1 if differences else 0


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="command", required=True)
    apply = sub.add_parser("apply")
    apply.add_argument("--dry-run", action="store_true")
    apply.add_argument("--only", action="append", default=[])
    check = sub.add_parser("check")
    check.add_argument("--only", action="append", default=[])
    args = parser.parse_args()
    # git の出力とこのスクリプトの表示が前後しないよう、行ごとに書き出す
    sys.stdout.reconfigure(line_buffering=True)
    if os.environ.get("HERDR_ENV") != "1":
        sys.exit("herdr のペインの中で実行してください")
    return {"apply": cmd_apply, "check": cmd_check}[args.command](args)


if __name__ == "__main__":
    sys.exit(main())
