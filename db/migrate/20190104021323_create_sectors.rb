class CreateSectors < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :sector
    add_column :companies, :sector_id, :integer

    create_table :sectors do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :sectors, :name, unique: true
    add_foreign_key :companies, :sectors
  end
end
