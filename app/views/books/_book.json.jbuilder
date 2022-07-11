json.extract! book, :id, :ISBN, :title, :placeholder, :description, :created_at, :updated_at
json.url book_url(book, format: :json)
