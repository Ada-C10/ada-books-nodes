require "test_helper"

describe SessionsController do
  it "login form" do
    get login_path

    must_respond_with :success
  end

  describe "login action" do
    it "can create a new user" do
      user_hash = {
        author: {
          name: 'katie'
        }
      }

      expect {
        post login_path, params: user_hash
      }.must_change 'Author.count', 1

      must_respond_with :redirect
      must_redirect_to root_path

      new_author = Author.find_by(name: user_hash[:author][:name])

      expect(new_author).wont_be_nil
      expect(session[:user_id]).must_equal new_author.id
    end
    it "should log in an existing user without changing the DB" do

    end

    it "should give a bad_request for an invalid author name" do

    end


  end

  it 'Sample' do
    people = 47

    expect {
      people += 5
    }.must_change 'people', 5


  end



end
