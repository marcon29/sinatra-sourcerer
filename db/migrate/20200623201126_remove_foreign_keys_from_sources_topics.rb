class RemoveForeignKeysFromSourcesTopics < ActiveRecord::Migration[5.2]  
  def change
    remove_column :sources, :topic_id, :integer
    remove_column :sources, :user_id, :integer
    remove_column :topics, :subject_id, :integer
  end
end
