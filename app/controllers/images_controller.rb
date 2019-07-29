class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    image_params = params.require(:image).permit(:url)
    @image = Image.new(image_params)
    if @image.valid?
      @image.save!
      flash[:success] = 'Post successfully created'
      redirect_to image_path(@image)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @image = Image.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
