require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  helpers do
    def logged_in
      !!current_user
    end

    def current_user
      session.include?("user_id")
    end
  end

  get '/' do
    erb :welcome
  end

end
