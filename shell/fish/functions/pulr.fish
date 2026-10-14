function pulr --description 'リモートのデフォルトブランチを rebase で取り込む（例: pulr / pulr upstream）'
    set -l remote origin
    if test (count $argv) -ge 1
        set remote $argv[1]
    end

    set -l branch (git symbolic-ref --quiet --short refs/remotes/$remote/HEAD 2>/dev/null | string replace "$remote/" '')
    # clone 以外で追加したリモートはローカルに HEAD を持たないので、リモートに直接問い合わせる
    if test -z "$branch"
        set branch (git ls-remote --symref $remote HEAD | string match -rg '^ref: refs/heads/(\S+)\s+HEAD$')
    end
    if test -z "$branch"
        echo "pulr: $remote のデフォルトブランチを取得できませんでした" >&2
        return 1
    end

    echo "→ git pull -p --rebase $remote $branch"
    git pull -p --rebase $remote $branch
end
