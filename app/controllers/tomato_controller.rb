class TomatoController < ApplicationController

  get '/tomatoes/all' do
    @all_tomatoes = Tomato.all

    if logged_in
      erb :'tomatoes/show_tomatoes'
    else
      redirect to "/login"
    end
  end

  post '/tomatoes' do
    @tomato = Tomato.new
    @tomato.variety = params["variety"]
    @tomato.growth_type = params["indeterminate"] || params["determinate"]
    @tomato.days = params["days"]
    @tomato.details = params["details"]
    @tomato.save

    @user = User.find_by_id(session["user_id"])
    @tomato.user_id = @user.id
    @tomato.save

    redirect to "/tomatoes/#{@tomato.id}"
  end

  get '/tomatoes' do
    erb :'tomatoes/new_variety'
  end

  get '/tomatoes/:id/edit' do

    @tomato = Tomato.find_by_id(params["id"])
    @user = User.find_by_id(@tomato.user_id)

    erb :'tomatoes/edit_tomato'
  end

  post '/tomatoes/:id' do

    @tomato = Tomato.find_by_id(params["id"])
    @user = User.find_by_id(@tomato.user_id)

    @tomato.variety = params["variety"]
    @tomato.growth_type = params["indeterminate"] || params["determinate"]
    @tomato.days = params["days"]
    @tomato.details = params["details"]
    @tomato.save
    @tomato.user_id = @user.id
    @tomato.save

    redirect to "/tomatoes/#{@tomato.id}"
  end

  get '/tomatoes/:id' do
    @tomato = Tomato.find_by_id(params["id"])
    @user = User.find_by_id(@tomato.user_id)

    erb :'tomatoes/show_tomato'
  end

  delete '/tomatoes/:id/delete' do

    @tomato = Tomato.find_by_id(params["id"])
    @user = User.find_by_id(@tomato.user_id)

    if @tomato.user_id == @user.id
      @tomato.delete
      redirect to "/user/#{@user.slug}"
    end
  end

end
