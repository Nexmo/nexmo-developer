require 'octokit'

class JobsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def code_example_push
    if validate_github_signature
      if params['ref'] == 'refs/heads/master'
        url = "https://api.travis-ci.org/repo/#{ENV['TRAVIS_REPO_ID']}/requests"
        RestClient.post(url, {
          "request": {
            "branch": 'master',
            "config": {
              "script": 'bundle exec rake diff:execute',
              "env": {
                "SSH_KEY_REQUIRED": true,
              },
            },
          },
        }.to_json, {
          content_type: :json,
          accept: :json,
          'Authorization': "token #{ENV['TRAVIS_TOKEN']}",
          'Travis-API-Version': '3',
        })

        render plain: 'Request forwarded to CI', status: :accepted
      else
        render plain: 'Request understood. Not master, not continuing', status: :ok
      end
    else
      head :unauthorized
    end
  end

  def open_pull_request
    if validate_ci_secret
      repo = ENV['GITHUB_REPO']
      branch_base = 'master'
      branch_head = params[:branch]
      title = '[AUTOMATED] Updated code examples'
      body = params[:body]

      client = Octokit::Client.new(access_token: ENV['GITHUB_PERSONAL_ACCESS_TOKEN'])
      client.login
      client.create_pull_request(repo, branch_base, branch_head, title, body)

      head :accepted
    else
      head :unauthorized
    end
  end

  private

  def validate_github_signature
    signature = "sha1=#{OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['CI_SECRET'], request.raw_post)}"
    Rack::Utils.secure_compare(signature, request.headers['X-Hub-Signature'])
  end

  def validate_ci_secret
    params['secret'] = ENV['CI_SECRET']
  end
end
