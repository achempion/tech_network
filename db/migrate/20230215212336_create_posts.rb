class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :website, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.string :link, null: false, index: { unique: true }
      t.datetime :published_at, null: false
      t.datetime :post_updated_at, null: false
      t.integer :applause, default: 0

      t.timestamps
    end
  end
end
