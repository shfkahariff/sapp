class Ticket < ApplicationRecord
    belongs_to :event, inverse_of: :tickets
end
