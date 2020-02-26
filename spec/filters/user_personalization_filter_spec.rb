require 'rails_helper'

RSpec.describe UserPersonalizationFilter do
  it 'returns input if it does not match filter' do
    input = <<~HEREDOC
      no options defined here
    HEREDOC

    expected_output = <<~HEREDOC
      no options defined here
    HEREDOC

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'returns input if api_key is blank' do
    filter = UserPersonalizationFilter.new({
        current_user: blank_api_key_user_mock,
    })
    input = <<~HEREDOC
      <pre><code>
      NEXMO_API_KEY
      NEXMO_API_SECRET
      </code></pre>
    HEREDOC

    expected_output = <<~HEREDOC
      <pre><code>
      NEXMO_API_KEY
      NEXMO_API_SECRET
      </code></pre>
    HEREDOC

    expect(filter.call(input)).to eql(expected_output)
  end

  it 'returns input if api_secret is blank' do
    filter = UserPersonalizationFilter.new({
        current_user: blank_api_secret_user_mock,
    })
    input = <<~HEREDOC
      <pre><code>
      NEXMO_API_KEY
      NEXMO_API_SECRET
      </code></pre>
    HEREDOC

    expected_output = <<~HEREDOC
      <pre><code>
      NEXMO_API_KEY
      NEXMO_API_SECRET
      </code></pre>
    HEREDOC

    expect(filter.call(input)).to eql(expected_output)
  end

  it 'returns input if input does not match but a valid user is provided' do
    filter = UserPersonalizationFilter.new({
        current_user: correct_user_mock,
    })

    input = <<~HEREDOC
      this is not the correct input
    HEREDOC

    expected_output = <<~HEREDOC
      this is not the correct input
    HEREDOC

    expect(filter.call(input)).to eql(expected_output)
  end

  it 'returns user api_key and api_secret if input matches' do
    filter = UserPersonalizationFilter.new({
        current_user: correct_user_mock,
    })
    input = <<~HEREDOC
      <pre><code>
      GET https://rest.nexmo.com/account/balance?api_key=NEXMO_API_KEY&api_secret=NEXMO_API_SECRET
      </code></pre>
    HEREDOC

    expected_output = <<~HEREDOC
      <pre><code>
      GET https://rest.nexmo.com/account/balance?api_key='12335'&amp;api_secret='123456'
      </code></pre>
    HEREDOC

    expect(filter.call(input)).to eql(expected_output)
  end

    private

  def correct_user_mock
    User.new({
        email: 'nexmo@nexmo.com',
        nexmo_developer_api_secret: 12345,
        api_key: 12335,
        api_secret: 123456,
    })
  end

  def blank_api_key_user_mock
    User.new({
        email: 'nexmo@nexmo.com',
        nexmo_developer_api_secret: 12345,
        api_secret: 123456,
    })
  end

  def blank_api_secret_user_mock
    User.new({
        email: 'nexmo@nexmo.com',
        nexmo_developer_api_secret: 12345,
        api_key: 12335,
    })
  end

  def blank_api_key_and_secret_user_mock
    User.new({
        email: 'nexmo@nexmo.com',
        nexmo_developer_api_secret: 12345,
    })
  end
end
