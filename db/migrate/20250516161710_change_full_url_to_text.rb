class ChangeFullUrlToText < ActiveRecord::Migration[7.1]
  def change
    change_column :shortened_urls, :full_url, :text
  end
end
