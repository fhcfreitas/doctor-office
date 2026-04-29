class CreateAvailableSlots < ActiveRecord::Migration[8.1]
  def change
    create_table :available_slots do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.string :status, null: false, default: "available"

      t.timestamps
    end

    add_index :available_slots, [ :user_id, :starts_at ]
  end
end
