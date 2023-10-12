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

New-Alias ggl Get-GitLog
New-Alias ggs Get-GitStatus
New-Alias gga Get-GitAddAll
New-Alias ggd Get-GitDiff
