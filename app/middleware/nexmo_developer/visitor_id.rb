module NexmoDeveloper
  class VisitorId
    def initialize(app)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)
      req.session['visitor_id'] ||= "G-#{SecureRandom.alphanumeric(8)}"
      @app.call(env)
    end
  end
end
