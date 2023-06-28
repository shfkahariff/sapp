class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :type
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
