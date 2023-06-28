class RemoveTypeFromTickets < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickets, :type, :string
  end
end
