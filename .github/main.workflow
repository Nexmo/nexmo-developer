workflow "Debug" {
  on = "pull_request"
  resolves = ["debug"]
}

action "debug" {
  uses = "actions/bin/debug@master"
}
