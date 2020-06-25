class ChangeTypeColumnInSources < ActiveRecord::Migration[5.2]
  def change
    change_table :sources do |t|
      t.rename :type, :media_type
    end
  end
end
