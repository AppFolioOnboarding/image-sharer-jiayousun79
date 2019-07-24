class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(url: params[:image][:url])
    if @image.valid?
      @image.save!
      redirect_to image_path(@image)
    else
      render :new
    end
  end

  def show
    @image = Image.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
