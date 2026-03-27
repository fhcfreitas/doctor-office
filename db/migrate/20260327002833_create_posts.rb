class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :subtitle
      t.text :content, null: false
      t.boolean :draft, null: false, default: true
      t.references :user, null: false, foreign_key: true
      t.boolean :newsletter_flag, null: false, default: false
      t.boolean :newsletter_sent, null: false, default: false
      t.datetime :published_at

      t.timestamps
    end

    add_index :posts, :newsletter_flag
    add_index :posts, :draft
    add_index :posts, :published_at
  end
end
