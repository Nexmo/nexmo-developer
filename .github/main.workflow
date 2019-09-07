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

workflow "append Heroku logs" {
  on = "deployment_status"
  resolves = ["append-heroku-logs"]
}

action "append-heroku-logs" {
  uses = "mheap/github-action-heroku-logs@master"
  secrets = ["GITHUB_TOKEN", "HEROKU_AUTH_TOKEN"]
}

workflow "Check Redirects" {
  resolves = ["check-redirects"]
  on = "pull_request"
}

action "check-redirects" {
  uses = "nexmo/github-actions/ndp-check-redirects@master"
  secrets = [
    "GITHUB_TOKEN"
  ]
}
