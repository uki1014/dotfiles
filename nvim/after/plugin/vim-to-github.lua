vim.g.to_github_clipboard = '1'

Maps.nmap('<Leader>gj', ':ToGithubBlobDevelopBranch<CR>', Maps.n)
Maps.nmap('<Leader>gb', ':ToGithubBlameDevelopBranch<CR>', Maps.n)
Maps.nmap('<Leader>G', ':ToGithubBlobCommitHash<CR>', Maps.n)
Maps.nmap('<Leader>GB', ':ToGithubBlameCommitHash<CR>', Maps.n)
Maps.nmap('<Leader>g', ':ToGithubTargetPullRequest<CR>', Maps.n)
Maps.nmap('<Leader>j', ':ToGithubTargetPullRequestFromCommitHash<CR>', Maps.n)
