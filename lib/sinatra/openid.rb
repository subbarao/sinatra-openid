gem 'rack-openid'
require 'rack'
require 'rack/openid'
require 'sinatra/base'
module Sinatra
  module Openid
    def self.registered(app)
      use Rack::Session::Cookie
      use Rack::OpenID
      get '/login' do
        %{<form action="/login" method="post">
          <p>
          <label for="openid_identifier">OpenID:</label>
          <input id="openid_identifier" name="openid_identifier" type="text" />
          </p>

          <p>
          <input name="commit" type="submit" value="Sign in" />
          </p>
        </form>}
      end

      get '/logout' do
        session.clear
        [ 302, { 'Location' => '/' }, [] ]
      end

      post '/login' do
        if resp = request.env["rack.openid.response"]
          if resp.status == :success
            "Welcome: #{resp.display_identifier}"
          else
            "Error: #{resp.status}"
          end
        else
          headers 'WWW-Authenticate' => Rack::OpenID.build_header(
          :identifier => params["openid_identifier"]
          )
          throw :halt, [401, 'got openid?']
        end
      end
    end
  end
  register Openid
end
