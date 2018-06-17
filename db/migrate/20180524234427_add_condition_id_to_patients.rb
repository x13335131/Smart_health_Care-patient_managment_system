class AddConditionIdToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :condition_id, :integer
  end
end
