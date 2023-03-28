class AddPreparationTimeToFood < ActiveRecord::Migration[6.1]
  def change
    add_column :foods, :prep_time, :integer, :default => 12
  end
end
