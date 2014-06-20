# Serve static files with Rack

A really simple Rack app that show how to serve static files.

To install Rack use:

    gem install rack

To start the app invoke:

    rackup

then open [http://localhost:9292](http://localhost:9292) in your browser and you should see the `index.html` file styled with `css/style.css` and the `images/rack.png` image.

Opening [http://localhost:9292/time](http://localhost:9292/time) should whow you the current timestamp.
