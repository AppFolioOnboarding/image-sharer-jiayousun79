class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    Image.create!(url: params[:image][:url])
    redirect_to :new_image
  end
end
