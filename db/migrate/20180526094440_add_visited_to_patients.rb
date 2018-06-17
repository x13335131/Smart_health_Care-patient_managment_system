class AddVisitedToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :visited, :date
  end
end
