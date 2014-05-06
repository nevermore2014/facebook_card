class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :name
      t.text :location
      t.text :img_url
      t.integer :num_post
      t.integer :num_like
      t.integer :num_comment
      t.integer :num_photo
      t.integer :num_status
      t.integer :num_link
      t.integer :num_video

      t.timestamps
    end
  end
end
