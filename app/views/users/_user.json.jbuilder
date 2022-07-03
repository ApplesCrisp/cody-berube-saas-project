json.extract! user, :id, :id, :username, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
