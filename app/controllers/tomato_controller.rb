class TomatoController < ApplicationController

  get '/all_plants' do
    binding.pry
    erb :'tomatoes/show_tomatoes'
  end

end
