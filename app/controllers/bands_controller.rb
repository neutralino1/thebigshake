class BandsController < ApplicationController
  def show
    @band = Band.find_by(url: params[:id])
  end

  def update
    @band = Band.find(params[:id])
    @band.increment(:play_count, 1).save
    render nothing: true
  end

end