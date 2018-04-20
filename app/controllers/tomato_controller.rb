class TomatoController < ApplicationController

  get '/tomatoes/all' do
    @all_tomatoes = Tomato.all

    erb :'tomatoes/show_tomatoes'
  end

  post '/tomatoes/new' do
    @tomato = Tomato.new
    @tomato.variety = params["variety"]
    @tomato.growth_type = params["growth_type"]
    @tomato.days = params["days"]
    @tomato.details = params["details"]
    @tomato.save

    @user = User.find_by_id(session["user_id"])

    erb :'tomatoes/show_tomato'
  end

  get '/tomatoes/new' do
    erb :'tomatoes/new_variety'
  end

  get '/tomatoes/:id/edit' do

    @tomato = Tomato.find_by_id(params["id"].to_i)
    @user = User.find_by_id(session["user_id"])

    erb :'tomatoes/edit_tomato'
  end

  post '/tomatoes/:id' do
    binding.pry
  end

end
