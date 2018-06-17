class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.string :fname
      t.string :sname
      t.date :dob
      t.string :address
      t.integer :phone_no
      t.string :infection
      t.string :injury
      t.text :observations

      t.timestamps
    end
  end
end
