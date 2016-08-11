json.extract! book, :id, :name, :published_date, :publisher_id, :created_at, :updated_at
json.url book_url(book, format: :json)