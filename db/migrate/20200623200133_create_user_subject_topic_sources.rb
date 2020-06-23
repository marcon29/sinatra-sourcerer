class CreateUserSubjectTopicSources < ActiveRecord::Migration[5.2]
  def change
    create_table :user_subject_topic_sources do |t|
      t.integer :user_id
      t.integer :subject_id
      t.integer :topic_id
      t.integer :source_id
    end
  end
end
