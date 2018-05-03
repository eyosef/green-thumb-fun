require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "secret"
  end

  helpers do
    def logged_in
      !!current_user
    end

    def current_user
      if session.include?("user_id")
        @user = User.find(session["user_id"])
      end 
    end
    
  end

  get '/' do
    Tomato.scraper

    erb :welcome
  end

end
