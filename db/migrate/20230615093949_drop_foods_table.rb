class DropFoodsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :foods
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
