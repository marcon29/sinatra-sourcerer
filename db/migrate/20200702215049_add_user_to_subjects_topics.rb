class AddUserToSubjectsTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :user_id, :integer
    add_column :topics, :user_id, :integer
  end
end
