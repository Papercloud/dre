class DreCreateDevices < ActiveRecord::Migration
  def change
    create_table :dre_devices do |t|
      t.string :token
      t.integer :owner_id
      t.string :owner_type

      t.timestamps null: false
    end

    add_index :dre_devices, [:owner_id, :owner_type]
    add_index :dre_devices, :token
  end
end
