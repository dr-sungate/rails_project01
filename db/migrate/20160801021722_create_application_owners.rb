class CreateApplicationOwners < ActiveRecord::Migration[5.0]
  def change
    create_table :application_owners do |t|
      t.integer :application_id
      t.integer :owner_id

      t.timestamps
    end
  end
end
