class VideosController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]


  def create
    @video = current_user.videos.build(video_params)
    if @video.save
      flash[:success] = '動画を投稿しました。'
      rename_video_url = ("public#{@video.video_url}").split('.')[0] + '.webm'
      `ffmpeg -i public#{@video.video_url} -f webm -vcodec libvpx -acodec libvorbis -aq 90 -ac 2 #{rename_video_url}`
      File.delete("public#{@video.video_url}")
      redirect_to root_url
    else
      @videos = current_user.videos.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '動画の投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @video.destroy
    flash[:success] = '動画を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  def video_params
    params.require(:video).permit(:name, :description, :video)
  end
  
  def correct_user
    @video = current_user.videos.find_by(id: params[:id])
    unless @video
      redirect_to root_url
    end
  end
end
