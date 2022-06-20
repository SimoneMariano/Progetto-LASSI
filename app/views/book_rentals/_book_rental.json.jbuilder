json.extract! book_rental, :id, :ISBN, :matricola, :start, :end, :created_at, :updated_at
json.url book_rental_url(book_rental, format: :json)
