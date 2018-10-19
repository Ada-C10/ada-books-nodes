class User < ApplicationRecord
  # Turn the auth hash into an instance
  # of class User
  def self.build_from_github(auth_hash)
   user = User.new
   user.uid = auth_hash[:uid]
   user.provider = 'github'
   user.name = auth_hash['info']['name']
   user.email = auth_hash['info']['email']

   # Note that the user has not been saved
   return user
  end
end
