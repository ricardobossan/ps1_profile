# Functions {{{

## Git Functions {{{
  function Get-GitLog {
    git log --all --oneline --graph --decorate $args
  }

  function Get-GitStatus {
    git status $args
  }

  function Get-GitAddAll {
    git add . $args
  }

  function Get-GitDiff {
    git diff -w $args
  }
  
  function Get-GitFetchAll {
    git fetch --all
  }
##}}}

## GitHub CLI Functions {{{
  function Gh-GetPR {
    gh pr view -c $args
  }

  function Gh-GetPRs {
    gh pr list $args
  }

  function Gh-GetPRic {
    $username=Get-GitHubUsername
      gh pr list -L 5000 -A "@me" $args
  }

  function Install-Jq {
    if (-not (Get-Command jq -ErrorAction SilentlyContinue)) {
      Write-Host "jq not found. Installing jq..."
        winget install jqlang.jq
    }
  }

  function Get-GitHubUsername {
# Run 'gh api user' to get the GitHub username
    $username = gh api user --jq '.login' -H 'Accept: application/vnd.github.v3+json'

# Return the username
    return $username.Trim()
  }

  function Get-PRListForAuthenticatedUser {
# Install jq if not already installed
#Install-Jq

# Get the GitHub username using the previously defined function
#$username = Get-GitHubUsername

# Call 'gh pr list' for the authenticated user
    gh pr list -A "@me" #$username
  }

  function Gh-GetIssueAll {
    gh issue list -L 5000 $args
  }

  function Gh-GetIssueAccessibilityAll {
    gh issue list -L 5000 -l tenet-accessibility $args
  }

  function Gh-GetIssueAccessibilityRelated {
    gh issue list -L 5000 -S accessibility $args
  }

  function Gh-GetIssueByNumber {
    gh issue view $args
  }

##}}}

# }}}

Install-Jq

# Aliases {{{

# Git Aliases {{{
  New-Alias ggl Get-GitLog
  New-Alias ggs Get-GitStatus
  New-Alias gga Get-GitAddAll
  New-Alias ggd Get-GitDiff
  New-Alias gfa Get-GitFetchAll
# }}}

# GitHub CLI Aliases {{{
  New-Alias gprl Gh-GetPRic
  New-Alias gpr Gh-GetPR
  New-Alias gia Gh-GetIssueAccessibilityAll
  New-Alias gira Gh-GetIssueAccessibilityRelated
  New-Alias gin Gh-GetIssueByNumber
# }}}

# }}}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
  $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
  if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
  }
