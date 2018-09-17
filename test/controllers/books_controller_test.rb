require "test_helper"

describe BooksController do
  it "should get index" do
    get books_index_url
    value(response).must_be :success?
  end

end
