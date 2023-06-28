class AddEventIdToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :event_id, :integer
    add_index :tickets, :event_id
  end
end
