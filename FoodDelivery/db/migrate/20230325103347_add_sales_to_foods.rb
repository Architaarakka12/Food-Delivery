class AddSalesToFoods < ActiveRecord::Migration[6.1]
  def change
    add_column :foods, :sales, :text
  end
end
