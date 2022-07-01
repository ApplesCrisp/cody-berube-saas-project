class User < ApplicationRecord
  def add_new_user(username, password)
    User.create(username: username, password: password)
  end
end
