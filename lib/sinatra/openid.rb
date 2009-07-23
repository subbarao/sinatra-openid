gem 'ruby-openid', '>=2.1.2'
require 'haml'
require 'sinatra/base'
gem 'rack-openid'
require 'rack/openid'
module Sinatra
  module Openid

    module Helpers

      def authorized?
        session[:authorized]
      end

      def root_url
        request.url.match(/(^.*\/{2}[^\/]*)/)[1]
      end

      def authorize!
        redirect '/login' unless authorized?
      end

      def logout!
        session[:authorized] = false
      end

      def verify_user( logged_in_user )
        options.admin_urls.find do | user |
          user == logged_in_user
        end
      end

    end

    def self.registered(app)

      app.helpers Openid::Helpers

      use Rack::Session::Cookie
      use Rack::OpenID

      get '/js/*.js' do
        public_dir = File.dirname(__FILE__)+"/../../public"
        path = File.expand_path(public_dir + unescape(request.path_info))
        pass unless File.file?(path)
        send_file path, :disposition => nil
      end

      get '/login' do
        haml :login,:views_directory => File.dirname(__FILE__)+"/../../views"
      end

      post '/login' do
        if resp = request.env["rack.openid.response"]
          if resp.status == :success
            if verify_user(resp.identity_url)
              session[:authorized] = true
              redirect '/'
            else
              "unable to verify user: #{resp.identity_url}"
            end
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

      get '/logout' do
        session.clear
        [ 302, { 'Location' => '/' }, [] ]
      end

    end
  end

  register Openid
end

