json.extract! view_reservation, :id, :created_at, :updated_at
json.url view_reservation_url(view_reservation, format: :json)
