class CreateWebsites < ActiveRecord::Migration[7.0]
  def change
    create_table :websites do |t|
      t.string :url, null: false, index: true
      t.string :feed_url, null: false, index: { unique: true }
      t.string :feed_title, null: false
      t.datetime :feed_synced_at

      t.timestamps
    end
  end
end
