class AddNextAptToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :next_apt, :date
  end
end
