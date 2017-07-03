class AddVideoToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :video, :string
  end
end
