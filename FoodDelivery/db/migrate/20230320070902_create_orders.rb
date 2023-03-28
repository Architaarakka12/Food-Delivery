class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :status, :default => "Pending"
      t.integer :total
      t.integer :vat
      t.integer :delivery_cost
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
