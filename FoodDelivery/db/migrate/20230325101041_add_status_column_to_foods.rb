class AddStatusColumnToFoods < ActiveRecord::Migration[6.1]
  def change
    add_column :foods, :status, :string, :default => "available"
  end
end
