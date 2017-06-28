class ImagesController < ApplicationController
  before_action :require_user_logged_in
   before_action :correct_user, only: [:destroy]


  def create
     @image = current_user.images.build(image_params)
    if @image.save
      flash[:success] = '写真を投稿しました。'
      redirect_to root_url
    else
      @images = current_user.images.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '写真の投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @image.destroy
    flash[:success] = '写真を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  def image_params
    params.require(:image).permit(:name, :description, :image)
  end
  
  def correct_user
    @image = current_user.images.find_by(id: params[:id])
    unless @image
      redirect_to root_url
    end
  end
end
