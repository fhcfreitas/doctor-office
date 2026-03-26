class AddInfosToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :admin?, :boolean
    add_column :users, :name, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :crm_registration, :integer
    add_column :users, :bio, :text
    add_column :users, :specialty, :string
  end
end
