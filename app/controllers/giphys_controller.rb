class GiphysController < ApplicationController

  def new
    gif = search_gif(params[:giphy][:search])
    @giphy = parse_giphy(gif)
  end

end