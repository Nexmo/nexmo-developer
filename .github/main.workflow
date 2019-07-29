workflow "PR Edited" {
  resolves = ["Create Review App"]
  on = "pull_request"
}

action "Create Review App" {
  uses = "docker://mheap/github-action-pr-heroku-review-app"
  secrets = [
    "GITHUB_TOKEN",
    "HEROKU_APPLICATION_ID",
    "HEROKU_AUTH_TOKEN",
  ]
}

workflow "on pull request merge, delete the branch" {
  on = "pull_request"
  resolves = ["branch cleanup"]
}

action "branch cleanup" {
  uses = "jessfraz/branch-cleanup-action@master"
  secrets = ["GITHUB_TOKEN"]
}

workflow "append Heroku logs" {
  on = "deployment_status"
  resolves = ["append-heroku-logs"]
}

action "append-heroku-logs" {
  uses = "mheap/github-action-heroku-logs@master"
  secrets = ["GITHUB_TOKEN", "HEROKU_AUTH_TOKEN"]
}

workflow "Debug" {
  on = "pull_request"
  resolves = ["debug"]
}

action "debug" {
  uses = "actions/bin/debug@master"
}
