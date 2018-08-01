class StaticController < ApplicationController
  def landing
    render layout: 'landing'
  end

  def documentation
    @navigation = :documentation

    @document_path = "/app/views/static/documentation.md"

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
    @document_title = "SDKs & Tools"
    render layout: 'page'
  end

  def community
    @navigation = :community
    @document_title = "Community"
    @upcoming_events = Event.upcoming
    @past_events_count = Event.past.count
    @sessions = Session.published
    @sessions = Session.all if current_user && current_user.admin?
    render layout: 'page'
  end

  def past_events
    @navigation = :community
    @document_title = "Community"
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

  def team
    @team = YAML.load_file("#{Rails.root}/config/team.yml")

    if current_user && current_user.admin?
      @careers = Career.all
    else
      @careers = Career.published
    end

    render layout: 'page'
  end
end
