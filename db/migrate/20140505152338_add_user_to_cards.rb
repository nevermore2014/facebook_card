class AddUserToCards < ActiveRecord::Migration
  def change
    add_reference :cards, :user, index: true
  end
end
