class OrderTicket < ApplicationRecord
  belongs_to :ticket
  belongs_to :cart

  def total
    ticket.price * quantity
  end

  def name
    ticket.name
  end
  
end