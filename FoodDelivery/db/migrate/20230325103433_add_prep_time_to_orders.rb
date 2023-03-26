class AddPrepTimeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :pickup_time, :integer, default: 0
  end
end
