class CreateActiveSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :active_sessions do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
