class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :description
      t.float :price

      t.timestamps null: false
    end
  end
end
