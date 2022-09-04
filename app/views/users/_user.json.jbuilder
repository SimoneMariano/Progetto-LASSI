json.extract! user, :id, :name, :surname, :image, :course_id, :email, :matricola, :created_at, :updated_at
json.url user_url(user, format: :json)
json.image url_for(user.image)