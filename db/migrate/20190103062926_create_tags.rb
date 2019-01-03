class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_join_table :companies, :tags

    add_foreign_key :companies_tags, :companies
    add_foreign_key :companies_tags, :tags
  end
end
