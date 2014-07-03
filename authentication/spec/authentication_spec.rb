require "spec_helper"

RSpec.describe "Authentication" do
  def app
    App
  end

  context 'not logged in' do
    describe "GET /" do
      it "should state that we are not logged in" do
        get "/", {}, {}
        expect(last_response.body).to include "Home Page\nNot logged in"
        expect(last_response).to be_ok
      end
    end

    describe "GET /hello" do
      it "should say hello to the stranger" do
        get "/hello", {}, {}
        expect(last_response.body).to include "Hello stranger"
        expect(last_response).to be_ok
      end
    end
  end

  context 'logged in' do
    let(:rack_env) {
      { 'rack.session' => {"username" => "user1"} }
    }

    describe "GET /" do
      it "should return the home page" do
        get "/", {}, rack_env
        expect(last_response.body).to include "Home Page"
        expect(last_response.body).to include "User: user1"
        expect(last_response.body).not_to include "Not logged in"
        expect(last_response).to be_ok
      end
    end

    describe "GET /hello" do
      it "should say welcome to the user" do
        get "/hello", {}, rack_env
        expect(last_response.body).to include "Welcome user1"
        expect(last_response).to be_ok
      end
    end
  end

  context 'flash messages', type: :feature do
    describe "GET /login" do
      it "should redirect to the home page and show a login messages" do
        visit "/login?username=user1&password=1resu"
        expect(page.body).to include "logged in as user1"
      end
    end

    describe "GET /logout" do
      it "should logout the user" do
        visit "/logout"
        expect(page.body).to include "logged out"
      end
    end
  end
end
