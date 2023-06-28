class DropDetailsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :details
  end
end
