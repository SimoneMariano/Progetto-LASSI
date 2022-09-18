json.extract! book_rental, :id, :book, :user, :startDate, :endDate, :created_at, :updated_at
json.url book_rental_url(book_rental, format: :json)
