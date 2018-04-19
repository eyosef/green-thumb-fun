class UserController < ApplicationController

  get '/signup' do
      if logged_in
        redirect to "/user_profile_page"
      else
        erb :'users/new_user'
      end
  end

  post '/signup' do
      if params["username"] == "" || params["username"] == " "
        redirect to "/signup"
      elsif params["password"] == "" || params["password"] == " "
        redirect to "/signup"
      elsif params["email"] == "" || params["email"] == " "
        redirect to "/signup"
      else
        @user = User.new
        @user.username = params["username"]
        @user.password = params["password"]
        @user.email = params["email"]
        @user.save
        @user.id = session["user_id"]

        redirect to "/users/profile_page"
      end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    binding.pry
    if @user && @user.password_digest == params["password"]
      redirect to "/user_profile_page"
    else
      redirect to "/login"
    end
  end

  get '/user_profile_page' do
    @user = User.find_by_id(session["user_id"])
    erb :'users/profile_page'
  end

  get '/edit_account' do
    @user = User.find_by_id(session["user_id"])
    erb :'users/edit_account'
  end

  post '/edit_account' do
    binding.pry
  end

end #class
