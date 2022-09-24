vim.g.to_github_clipboard = '1'

maps.nmap('<Leader>gj', ':ToGithubBlobDevelopBranch<CR>', maps.n)
maps.nmap('<Leader>gb', ':ToGithubBlameDevelopBranch<CR>', maps.n)
maps.nmap('<Leader>G', ':ToGithubBlobCommitHash<CR>', maps.n)
maps.nmap('<Leader>GB', ':ToGithubBlameCommitHash<CR>', maps.n)
maps.nmap('<Leader>g', ':ToGithubTargetPullRequest<CR>', maps.n)
maps.nmap('<Leader>j', ':ToGithubTargetPullRequestFromCommitHash<CR>', maps.n)
