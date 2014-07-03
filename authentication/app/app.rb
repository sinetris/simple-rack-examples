require 'forwardable'

class App
  class << self
    extend Forwardable
    def_delegators :app, :map, :use, :call
    alias :_new :new
    def new(*args, &block)
      app.run _new(*args, &block)
      app
    end
    def app
      @app ||= Rack::Builder.new
    end
  end

  use Rack::Session::Cookie, secret: SecureRandom.hex(64)
  use Rack::ShowExceptions
  use Rack::Flash, accessorize: [:notice]

  map '/login' do
    run lambda { |env|
      req = Rack::Request.new(env)
      user = User.find(req.params["username"])
      if user && user.autenticate(req.params["password"])
        req.session[:username] = user.username
        env['x-rack.flash'][:notice] = "logged in as #{user.username}"
      else
        env['x-rack.flash'][:notice] = "invalid credential"
      end
      res = Rack::Response.new
      res.redirect(req.base_url)
      res.finish
    }
  end

  map '/logout' do
    run lambda { |env|
      req = Rack::Request.new(env)
      req.session[:username] = nil
      env['x-rack.flash'][:notice] = "logged out"
      res = Rack::Response.new
      res.redirect(req.base_url)
      res.finish
    }
  end

  map "/" do
    run lambda { |env|
      req = Rack::Request.new(env)
      body = ["Home Page\n"]
      if notice = env['x-rack.flash'][:notice]
        body << "#{notice}\n"
      end
      if req.session[:username]
        body << "User: #{req.session[:username]}"
      else
        body << "Not logged in"
      end
      [200, {'Content-Type' => 'text/plain'}, body]
    }
  end

  map "/hello" do
    run lambda { |env|
      req = Rack::Request.new(env)
      body = [""]
      if req.session[:username]
        body << "Welcome #{req.session[:username]}!"
      else
        body << "Hello stranger!"
      end
      [200, {'Content-Type' => 'text/plain'}, body]
    }
  end
end
