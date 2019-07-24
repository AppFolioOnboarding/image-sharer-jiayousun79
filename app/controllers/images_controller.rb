class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    image_params = params.require(:image).permit(:url)
    @image = Image.new(image_params)
    if @image.valid?
      @image.save!
      redirect_to :new_image
    else
      render :new, status: :unprocessable_entity
    end
  end
end
