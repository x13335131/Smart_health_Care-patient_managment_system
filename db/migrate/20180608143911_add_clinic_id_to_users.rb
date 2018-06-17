class AddClinicIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :clinic, foreign_key: true
  end
end
