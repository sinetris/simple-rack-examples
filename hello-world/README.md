Hello Word
==========

A really simple Rack app that show "Hello World!".

To make a Rack app we need an object that respond to the `call` method, take the environment hash as a parameter, and return an Array with three elements:

* The HTTP response code
* A Hash of headers
* The response body, which must respond to `each`

To install Rack, use:

    gem install rack

To start the app invoke:

    rackup

then open http://localhost:9292 in your browser.
