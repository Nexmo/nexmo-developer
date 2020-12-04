subdomain_key = 'SLACK_SUBDOMAIN'
token_key = 'SLACK_TOKEN'

subdomain = ENV[subdomain_key]
token = ENV[token_key]

# If we're missing both a subdomain and a token, we're probably in development mode and don't need to
# worry about any of the following
return unless subdomain || token

# Do we have a slack token without a subdomain? If so, fail to boot
abort("#{token_key} provided, but #{subdomain_key} not found") if token && !subdomain

# How about a subdomain without a token? If so, fail to boot
abort("#{subdomain_key} provided, but #{token_key} not found") if subdomain && !token

# If we have both, make sure that the token provided is for that subdomain.
# If it's not, you know the drill, fail to boot
response = RestClient.post 'https://slack.com/api/auth.test', {
  token: ENV['SLACK_TOKEN'],
}

response = JSON.parse(response)

abort("Unable to validate Slack auth token: #{response['error']}") unless response['ok']

# If it's a valid token, make sure it's for the team we want to invite people to
expected_team_url = "https://#{subdomain}.slack.com/"
abort("The Slack token provided provides access to #{response['url']}, but we expected it to provide access to #{expected_team_url}") unless response['url'] == expected_team_url
