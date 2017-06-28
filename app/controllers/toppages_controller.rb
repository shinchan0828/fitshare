class ToppagesController < ApplicationController
  def index
     if logged_in?
      @user = current_user
      @image = current_user.images.build  # form_for 用
      @images = current_user.images.order('created_at DESC').page(params[:page])
     end
  end
end
