class Cart < ApplicationRecord
    has_many :order_tickets, dependent: :destroy
    has_many :carts, through: :order_tickets

    #def_total
    def total
        order_tickets.to_a.sum { |order_tickets| order_tickets.total }
    end
    
end
