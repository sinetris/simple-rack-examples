app = Rack::Builder.app do
  use Rack::Static, urls: ["/css", "/images"], root: 'public', index: 'index.html'
  map '/time' do
    run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ["Time: #{Time.now}"]] }
  end
end

run app
