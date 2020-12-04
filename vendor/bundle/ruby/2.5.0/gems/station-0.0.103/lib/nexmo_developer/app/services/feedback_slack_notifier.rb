class FeedbackSlackNotifier
  def self.call(feedback)
    new(feedback).notify!
  end

  def initialize(feedback)
    @feedback = feedback
    @notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK'], username: 'feedbot'
  end

  def emoji
    case @feedback.sentiment
    when 'negative' then ':-1:'
    when 'positive' then ':+1:'
    else ':neutral_face:'
    end
  end

  def slack_color
    case @feedback.sentiment
    when 'negative' then 'danger'
    when 'positive' then 'good'
    else '#ccc'
    end
  end

  def admin_url
    "#{ENV['FEEDBOT_PROTOCOL']}://#{ENV['FEEDBOT_HOST']}/admin/feedbacks/#{@feedback.id}"
  end

  def state
    @feedback.created_at == @feedback.updated_at ? 'New' : 'Updated'
  end

  def params
    @params ||= begin
      options = {
        channel: '#documentation-feedbot-comments',
        attachments: [
          {
            title: "#{emoji} #{state} #{@feedback.sentiment.upcase_first} feedback",
            title_link: admin_url,
            text: '-',
            color: slack_color,
            fields: [
              {
                title: ':link: URL',
                value: @feedback.resource.uri,
              },
              {
                title: ':hammer_and_wrench: Nexmo Developer Admin Link',
                value: admin_url,
              },
            ],
          },
        ],
      }

      if @feedback.owner.email
        options[:attachments][0][:fields] << {
          title: ':bust_in_silhouette: Author',
          value: @feedback.owner.email,
        }
      end

      options[:attachments][0][:fields] << {
        title: ':speech_balloon: Feedback',
        value: body,
      }

      if @feedback.code_language
        options[:attachments][0][:fields] << {
          title: ':computer: Code Language',
          value: @feedback.code_language,
        }
      end

      options
    end
  end

  def notify!
    @notifier.post params
  end

  def body
    <<~HEREDOC
      #{@feedback.config.title}

      *Paths:*
      #{paths.map { |p| "\t#{p}" }.join("\n")}

      *Answers:*
      #{answers.map { |a| "\t#{a}" }.join("\n")}
    HEREDOC
  end

  def paths
    @paths ||= @feedback.config.paths.map.with_index do |path, path_index|
      if @feedback.path == path_index
        "*#{path['question']}*"
      else
        path['question']
      end
    end
  end

  def answers
    @answers ||= @feedback.config.paths[@feedback.path]['steps'].map.with_index do |step, index|
      case step['type']
      when 'textarea'
        <<~HEREDOC
          *#{step['label'] || step['title']}*
          \t\t#{@feedback.steps[index]}
        HEREDOC
      when 'plain'
        "*#{step['title']}*"
      when 'radiogroup'
        options = step['questions'].map.with_index do |question, question_index|
          if question_index == @feedback.steps[index]
            "*#{question}*"
          else
            "#{question}"
          end
        end
        <<~HEREDOC
          *#{step['title']}*
          #{options.map { |o| "\t\t#{o}" }.join("\n")}
        HEREDOC
      when 'fieldset'
        fields = step['fields'].map.with_index do |field, _field_index|
          "*#{field['label']}:* #{@feedback.steps[index][field['name']]}"
        end
        <<~HEREDOC
          *#{step['title']}*
          #{fields.map { |f| "\t\t#{f}" }.join("\n")}
        HEREDOC
      end
    end
  end
end
