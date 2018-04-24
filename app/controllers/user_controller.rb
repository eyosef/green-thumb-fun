require 'rack-flash'

class UserController < ApplicationController

  use Rack::Flash

  get '/signup' do
      erb :'users/new_user'
  end

  post '/signup' do

      @user = User.create(params)

      if @user.valid?
        session.clear
        session["user_id"] = @user.id
        redirect to "/user/#{@user.slug}"
      else
        flash[:info_taken] = "It looks like the username or email address already belongs to another user. Please try again."
        erb :'users/new_user'
      end
  end

  get '/login' do
      erb :'users/login'
  end

  post '/login' do

    @user = User.find_by(username: params["username"])

    if @user && @user.password_digest == params["password"]
      session.clear
      session["user_id"] = @user.id
      redirect to "/user/#{@user.slug}"
    else
      redirect to "/login"
    end
  end

  get '/user/:slug' do
    @user = User.find_by_slug(params["slug"])

    erb :'users/profile_page'
  end

  get '/slugify' do
    @user = User.find_by_id(session["user_id"])
    if @user
      redirect to "/user/#{@user.slug}"
    else
      erb :'/'
    end
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
        session.clear
        erb :'welcome'
      end
  end

  get '/calendar' do
      @start_date = Date.today

      @current_month = Date.today.month
      redirect to "calendar/#{@current_month}"
  end

  get '/calendar/:month' do
      erb :'calendars/user_calendar'
  end

  get '/previous_month/:month' do
    @date = Date.parse(params["month"])
    @end_of_prev_month = @date.beginning_of_month - 1
    @prev_month = @end_of_prev_month.beginning_of_month

    redirect to "calendar/prev/#{@prev_month}"
  end

  get '/calendar/prev/:prev_month' do
    @prev_month = Date.parse(params["prev_month"])

    erb :'calendars/prev_month'
  end

end #class
