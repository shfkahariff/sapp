json.extract! ticket, :id, :type, :quantity, :price, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
