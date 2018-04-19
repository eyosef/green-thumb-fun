class TomatoController < ApplicationController

  get '/tomatoes/all' do
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
    @tomato.id = @user.tomato_id
    @user.tomato_id = @tomato.id

    erb :'tomatoes/show_tomato'
  end

  get '/tomatoes/new' do
    erb :'tomatoes/new_variety'
  end

  get '/tomatoes/:id/edit' do
    binding.pry
    @tomato = Tomato.find_by(params["id"].to_i)
    @user = User.find_by(session["user_id"])
  end

end
