class ToppagesController < ApplicationController
  def index
    @inquiry = Inquiry.new
     if logged_in?
      @user = current_user
      @video = current_user.videos.build  # form_for 用
      @videos = current_user.videos.order('created_at DESC').page(params[:page])
     end
  end
end
