class StaticController < ApplicationController
  def default_landing
    # Get URL and split the / to retrieve the landing page name
    yaml_name = request.fullpath.split('/')[1]

    @landing_config = YAML.load_file("#{Rails.root}/config/landing_pages/#{yaml_name}.yml")

    @landing_config['rows'].each do |row|
      some_columns_have_widths = row['columns'].select { |c| c['width'] }.count.positive?
      if some_columns_have_widths
        row['columns'] = row['columns'].map do |c|
          c['width'] ||= 1
          c
        end
        row['column_count'] = row['columns'].map { |c| c['width'] }.sum
      end
    end

    render layout: 'default_landing'
  end

  def landing
    render layout: 'landing'
  end

  def documentation
    @navigation = :documentation

    @document_path = '/app/views/static/documentation.md'

    # Read document
    document = File.read("#{Rails.root}/#{@document_path}")

    # Parse frontmatter
    @frontmatter = YAML.safe_load(document)

    @document_title = @frontmatter['title']

    @content = MarkdownPipeline.new.call(document)

    @namespace_path = "_documentation/#{@product}"
    @namespace_root = '_documentation'
    @sidenav_root = "#{Rails.root}/_documentation"

    render layout: 'documentation'
  end

  def tools
    @navigation = :tools
    @document_title = 'SDKs & Tools'
    render layout: 'page'
  end

  def community
    @navigation = :community
    @document_title = 'Community'
    @upcoming_events = Event.upcoming
    @past_events_count = Event.past.count
    @sessions = Session.published
    @sessions = Session.all if current_user&.admin?
    render layout: 'page'
  end

  def past_events
    @navigation = :community
    @document_title = 'Community'
    @past_events = Event.past
    render layout: 'page'
  end

  def contribute
    # Read document
    document = File.read("#{Rails.root}/app/views/static/contribute.md")

    # Parse frontmatter
    @frontmatter = YAML.safe_load(document)

    @document_title = @frontmatter['title']

    @content = MarkdownPipeline.new.call(document)

    render layout: 'static'
  end

  def legacy
    # Read document
    document = File.read("#{Rails.root}/app/views/static/legacy.md")

    # Parse frontmatter
    @frontmatter = YAML.safe_load(document)
    @document_title = @frontmatter['title']
    @content = MarkdownPipeline.new.call(document)

    render layout: 'page'
  end

  def robots
    render 'robots.txt'
  end

  def podcast
    # Get URL and split the / to retrieve the landing page name
    yaml_name = request.fullpath.split('/')[1]

    # Load the YAML for that particular page
    @content = YAML.load_file("#{Rails.root}/config/landing_pages/#{yaml_name}.yml")

    render layout: 'landing'
  end

  def developer_spotlight
    render layout: 'landing'
  end

  def migrate
    render layout: 'landing'
  end

  def migrate_details
    page = params[:guide].split('/')[0]

    @namespace_path = "_documentation/#{page}"
    @namespace_root = '_documentation'
    @sidenav_root = "#{Rails.root}/_documentation"
    @skip_feedback = true

    if page == 'sms'
      @active_path = '/messaging/sms/overview'
      @active_title = 'Migrate from Tropo'
      @product = 'SMS'
      @product_list = 'messaging/sms'
      @blocks = [
        {
          'title' => 'Send an SMS',
          'nexmo' => '_examples/migrate/tropo/send-an-sms/nexmo',
          'tropo' => '_examples/migrate/tropo/send-an-sms/tropo',
          'content' => <<~TEXT
            Sending an SMS with Nexmo couldn't be easier! Tell us who the message is from, who to send it
            to and the text that you'd like to send and we'll take care of the rest.

            With support for [six different languages](/tools) and a simple [REST API](/api/sms), you can
            get started with the Nexmo SMS API in under 10 minutes!
          TEXT
        },
      ]
    elsif page == 'voice'
      @active_path = '/voice/voice-api/overview'
      @active_title = 'Migrate from Tropo'
      @product = 'Voice'
      @product_list = 'voice/voice-api'
      @blocks = [
        {
          'title' => 'Make an outbound call',
          'nexmo' => '_examples/migrate/tropo/make-an-outbound-call/nexmo',
          'tropo' => '_examples/migrate/tropo/make-an-outbound-call/tropo',
          'content' => <<~TEXT
            When making a voice call with Tropo you provide the words to be spoken directly in your application.
            On the Nexmo platform, calls are controlled using an [NCCO](/voice/voice-api/ncco-reference), which is a JSON file that tells the Nexmo voice API how to interact with the call.

            In the example below, we use a static JSON file that returns a single `talk` action containing text which will be spoken in to the call.

            ```json
            [
              {
                "action": "talk",
                "voiceName": "Russell",
                "text": "You are listening to a test text-to-speech call made with Nexmo Voice API"
              }
            ]
            ```

            Text-to-speech is just one of the many actions you can perform with the Nexmo voice API. You can [record calls](/voice/voice-api/ncco-reference#record),
            [stream audio](/voice/voice-api/ncco-reference#stream), [build interactive menus](/voice/voice-api/ncco-reference#input) and more! Take
            a look at our [NCCO documentation](/voice/voice-api/ncco-reference) for more information

          TEXT
        },
      ]
    else
      return render 'static/404', status: :not_found, formats: [:html]
    end

    @building_blocks = @blocks.map do |block|
      block['nexmo'] = "<h2>Nexmo</h2>
        ```building_blocks
          code_only: true
          source: #{block['nexmo']}
        ```"

      block['tropo'] = "<h2>Tropo</h2>
        ```building_blocks
          code_only: true
          source: #{block['tropo']}
        ```"

      block
    end
    render layout: 'landing'
  end

  def team
    @team = YAML.load_file("#{Rails.root}/config/team.yml")

    if current_user&.admin?
      @careers = Career.all
    else
      @careers = Career.published
    end

    render layout: 'page'
  end
end
