class CreateSourceTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :source_topics do |t|
      t.integer :source_id
      t.integer :topic_id
    end
  end
end
