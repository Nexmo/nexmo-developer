module NexmoDeveloper
  class BuildingBlockRedirect
    def initialize(app)
      @app = app
    end

    def redirect(location)
      [301, { 'Location' => location, 'Content-Type' => 'text/html' }, ['Moved Permanently']]
    end

    def call(env)
      req = Rack::Request.new(env)
      return redirect(req.path.gsub('/building-blocks/', '/code-snippets/')) if req.path.include? '/building-blocks/'
      @app.call(env)
    end
  end
end
