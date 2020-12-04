class StaticController < ApplicationController
  before_action :canonical_redirect, only: :documentation

  def default_landing
    yaml_name = request[:landing_page]

    if File.exist?("#{Rails.configuration.docs_base_path}/custom/landing_pages/#{yaml_name}.yml")
      @landing_config = YAML.load_file("#{Rails.configuration.docs_base_path}/custom/landing_pages/#{yaml_name}.yml")
    else
      @landing_config = YAML.load_file("#{Rails.root}/config/landing_pages/#{yaml_name}.yml")
    end

    @landing_config['page'].each do |row|
      some_columns_have_widths = row['row'].select { |c| c['width'] }.count.positive?
      if some_columns_have_widths
        row['row'] = row['row'].map do |c|
          c['width'] ||= 1
          c
        end
        row['column_count'] = row['row'].map { |c| c['width'] }.sum
      end
    end

    if request.path.delete('/') == 'community'
      @upcoming_events = Event.upcoming
      @past_events_count = Event.past.count
      @navigation = :community

      @hash = Gmaps4rails.build_markers(@upcoming_events.reject(&:remote?)) do |event, marker|
        event.geocode
        marker.lat event.latitude
        marker.lng event.longitude
        marker.infowindow event.title
      end
    end

    if request.path.delete('/') == 'team'
      @team ||= LoadConfig.load_file('config/team.yml')
      @careers = Greenhouse.devrel_careers
    end

    if request.path.sub!('/', '') == 'migrate/tropo/sms'
      migrate_tropo
    elsif request.path.sub!('/', '') == 'migrate/tropo/voice'
      migrate_tropo
    end

    @navigation = yaml_name.to_sym
    render layout: 'landing'
  end

  def event_search
    @events = Event.search(params[:query]) if params[:query]

    @hash = Gmaps4rails.build_markers(@events.reject(&:remote?)) do |event, marker|
      event.geocode
      marker.lat event.latitude
      marker.lng event.longitude
      marker.infowindow event.title
    end

    respond_to do |format|
      format.js { render partial: 'static/default_landing/partials/event_search_results.js.erb' }
    end
  end

  def landing
    render layout: 'landing'
  end

  def documentation
    document ||= Nexmo::Markdown::DocFinder.find(
      root: "#{Rails.configuration.docs_base_path}/_documentation",
      document: 'index',
      language: params[:locale]
    )

    @document_path = document.path

    # Parse frontmatter
    @frontmatter = YAML.safe_load(document.path)

    @document_title = @frontmatter['title']

    @content = Nexmo::Markdown::Renderer.new(locale: params[:locale]).call(File.read(document.path))

    @navigation = :documentation

    @sidenav = Sidenav.new(
      request_path: request.path,
      navigation: @navigation,
      product: @product,
      locale: params[:locale]
    )

    render layout: 'documentation'
  end

  def community
    @navigation = :community
    @document_title = 'Community'
    @upcoming_events = Event.upcoming
    @past_events_count = Event.past.count
    @sessions = Session.visible_to(current_user).order(created_at: :desc)
    render layout: 'page'
  end

  def past_events
    @navigation = :community
    @document_title = 'Community'
    @past_events = Event.past
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

  def team
    @team ||= LoadConfig.load_file('config/team.yml')
    @careers = Greenhouse.devrel_careers

    render layout: 'page'
  end

  def migrate_tropo
    @active_title = 'Migrate from Tropo'

    @building_blocks = @landing_config['page'][0]['row'][0]['column'][0]['migrate_details']['blocks'].map do |block|
      block['nexmo'] = "<h2>Nexmo</h2>
        ```code_snippets
          code_only: true
          source: #{block['nexmo']}
        ```"

      block['tropo'] = "<h2>Tropo</h2>
        ```code_snippets
          code_only: true
          source: #{block['tropo']}
        ```"

      block
    end
  end

  def spotlight
    response = RestClient.post(
      'https://hooks.zapier.com/hooks/catch/1936493/oyzjr4i/',
      params.permit(:name, :email_address, :background, :outline, :previous_content).to_h
    )

    if response.code == 200
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def blog_cookie
    # This is the first touch time so we only want to set it if it's not already set
    set_utm_cookie('ft', Time.now.getutc.to_i) unless cookies[:ft]

    # Clear out old values that might not be set
    cookies.delete('utm_campaign', domain: :all)
    cookies.delete('utm_term', domain: :all)
    cookies.delete('utm_content', domain: :all)

    # These are the things we'll be tracking through the customer dashboard
    set_utm_cookie('utm_medium', 'dev_education')
    set_utm_cookie('utm_source', 'blog')
    set_utm_cookie('utm_campaign', params['c']) if params['c']
    set_utm_cookie('utm_content', params['ct']) if params['ct']
    set_utm_cookie('utm_term', params['t']) if params['t']

    redirect_to 'https://dashboard.nexmo.com/sign-up'
  end

  private

  def canonical_redirect
    return if params[:locale] != I18n.default_locale.to_s

    redirect_to documentation_path(locale: nil)
  end
end
