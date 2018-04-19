class TomatoController < ApplicationController

  get '/all_plants' do
    erb :'tomatoes/show_tomatoes'
  end

end
