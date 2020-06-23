class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.string :name
      t.string :url
      t.string :pub
      t.text :synopsis
      t.string :author
      t.datetime :pub_date
      t.string :type
      t.text :notes
      t.boolean :public
      t.timestamps
      t.integer :user_id
      t.integer :topic_id
    end
  end
end
