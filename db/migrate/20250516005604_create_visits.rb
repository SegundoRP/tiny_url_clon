class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.references :shortened_url, null: false, foreign_key: true
      t.string :ip_address, null: false
      t.string :user_agent
      t.string :referer

      t.timestamps
    end
  end
end
