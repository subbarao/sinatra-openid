gem 'rack-openid'
require 'rack'
require 'haml'
require 'rack/openid'
require 'sinatra/base'
module Sinatra
  module Openid

    module Helpers

      def authorized?
        session[:authorized]
      end

      def authorize!
        redirect '/login' unless authorized?
      end
      def logout!
        session[:authorized] = false
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

      get '/logout' do
        session.clear
        [ 302, { 'Location' => '/' }, [] ]
      end

      post '/login' do
        if resp = request.env["rack.openid.response"]
          if resp.status == :success && options.admin_urls? && options.admin_urls.index(resp.identity_url).nil?
            session[:authorized] = true
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
