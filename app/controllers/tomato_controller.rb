class TomatoController < ApplicationController

  get '/all_tomatoes' do
    erb :'tomatoes/show_tomatoes'
  end

  get '/new_variety' do
    erb :'tomatoes/new_variety'
  end

  post '/new_variety' do
  end

end
