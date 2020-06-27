class ChangePubDateFormat < ActiveRecord::Migration[5.2]
  def change
    change_column :sources, :pub_date, :date
  end
end
