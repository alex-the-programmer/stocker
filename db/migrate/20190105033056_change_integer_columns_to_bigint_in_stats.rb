class ChangeIntegerColumnsToBigintInStats < ActiveRecord::Migration[5.2]
  def change
    change_column :stats, :shares_outstanding, :bigint
  end
end
