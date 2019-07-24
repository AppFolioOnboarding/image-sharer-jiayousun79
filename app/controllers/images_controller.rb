class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(url: params[:image][:url])
    if @image.valid?
      @image.save!
      redirect_to :new_image
    else
      render :new
    end
  end
end
