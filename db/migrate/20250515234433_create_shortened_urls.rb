class CreateShortenedUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :shortened_urls do |t|
      t.string :full_url, null: false, index: true
      t.string :token, index: { unique: true }

      t.timestamps
    end
  end
end
