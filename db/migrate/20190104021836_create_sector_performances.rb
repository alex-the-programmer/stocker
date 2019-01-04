class CreateSectorPerformances < ActiveRecord::Migration[5.2]
  def change
    create_table :sector_performances do |t|
      t.belongs_to :sector, null: false
      t.decimal :performance, null: false
      t.date :period, null: false
      t.date :last_updated, null: false

      t.timestamps
    end

    add_index :sector_performances, [:sector_id, :last_updated], unique: true
    add_foreign_key :sector_performances, :sectors
  end
end
