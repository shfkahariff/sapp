class Event < ApplicationRecord
    has_many :tickets, dependent: :destroy, inverse_of: :event
    accepts_nested_attributes_for :tickets, allow_destroy: true, reject_if: :all_blank
end
