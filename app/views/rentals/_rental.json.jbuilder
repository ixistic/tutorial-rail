json.extract! rental, :id, :book, :user, :rental_date, :created_at, :updated_at
json.url rental_url(rental, format: :json)