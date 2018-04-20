class UserController < ApplicationController

  get '/signup' do
      if logged_in
        redirect to "/user/:id"
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
    if logged_in
      redirect to "/user/:id"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.password_digest == params["password"]
      redirect to "/user/:id"
    else
      redirect to "/login"
    end
  end

  get '/user/:id' do
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

  get '/logout' do
      @user = User.find_by_id(session["user_id"])
      if @user
        redirect to "/"
      end
  end

end #class
