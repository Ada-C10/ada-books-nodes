require "test_helper"

describe SessionsController do

  describe "create" do
    it "Can log in an existing user" do
      # Arrange
      user = users(:grace)

      # Tell OmniAuth to use this user's info when it sees
      # an auth callback from github
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Act
      expect {
        get auth_callback_path('github')
      }.wont_change('User.count')

      # Assert
      must_redirect_to root_path
      expect(session[:user_id]).must_equal user.id
    end

    it "Can log in a new user with good data" do
      # Arrange
      user = users(:grace)
      user.destroy

      # Tell OmniAuth to use this user's info when it sees
      # an auth callback from github
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Act
      expect {
        get auth_callback_path('github')
      }.must_change('User.count', +1)

      # Assert
      must_redirect_to root_path
      expect(session[:user_id]).wont_be_nil
    end

    it "Rejects a user with invalid data" do
    end
  end

end
