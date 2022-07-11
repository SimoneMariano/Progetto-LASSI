json.extract! secondhand, :id, :book_id, :user_id, :image, :description, :created_at, :updated_at
json.url secondhand_url(secondhand, format: :json)
json.image url_for(secondhand.image)
