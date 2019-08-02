class ImagesController < ApplicationController
  def index
    if params[:tag]
      @images = Image.tagged_with(params[:tag]).order(created_at: :desc)
      flash.now[:warning] = 'No images under this tag' unless @images.any?
    else
      @images = Image.all.order(created_at: :desc)
    end
  end

  def new
    @image = Image.new
  end

  def create
    image_params = params.require(:image).permit(:url, :tag_list)
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

  def destroy
    Image.destroy(params[:id])
    redirect_to images_path
    flash[:success] = 'Post successfully deleted'
  rescue ActiveRecord::RecordNotFound
    redirect_to images_path
    flash[:warning] = 'Nothing to delete'
  end
end
