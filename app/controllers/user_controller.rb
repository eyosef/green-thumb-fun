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
        @user.password_digest = params["password"]
        @user.email = params["email"]
        @user.save
        session["user_id"] = @user.id

        redirect to "/user_profile_page"
      end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
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

  post '/edit_account' do
    if params["username"] == "" || params["username"] == " "
      redirect to "/edit_account"
    elsif params["password"] == "" || params["password"] == " "
      redirect to "/edit_account"
    elsif params["email"] == "" || params["email"] == " "
      redirect to "/edit_account"
    else
      @user = User.find_by_id(session["user_id"])
      @user.username = params["username"]
      @user.password_digest = params["password"]
      @user.email = params["email"]
      @user.save
      erb :'users/profile_page'
    end
  end

  get '/edit_account' do
    @user = User.find_by_id(session["user_id"])
    erb :'users/edit_account'
  end

end #class
