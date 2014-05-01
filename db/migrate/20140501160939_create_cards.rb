class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :name
      t.text :location
      t.integer :num_post
      t.integer :num_like
      t.string :num_comment

      t.timestamps
    end
  end
end
