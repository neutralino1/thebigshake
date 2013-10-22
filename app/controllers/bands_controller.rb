class BandsController < ApplicationController
  def show
    @band = Band.find_by(url: params[:id])
  end
end