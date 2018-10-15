require "test_helper"

describe BooksController do
  it "should get index" do
    get books_path

    must_respond_with :success
  end

  describe "show" do
    it "should get a book's show page" do
      # Arrange
      id = books(:poodr).id

      # Act
      get book_path(id)

      # Assert
      must_respond_with :success
    end

    it "should respond with not_found if given an invalid id" do
      # Arrange - invalid id
      id = -1

      # Act
      get book_path(id)

      # Assert
      must_respond_with :not_found
      expect(flash[:danger]).must_equal "Cannot find the book -1"
    end
  end

  describe "new" do
    it "can get the new book page" do

      # Act
      get new_book_path

      # Assert
      must_respond_with :success
    end
  end

  describe "edit" do
    it "can get the edit page for a valid book" do
      # Arrange
      id = books(:poodr).id

      # Act
      get edit_book_path(id)

      # Assert
      must_respond_with :success
    end

    it "should respond with not_found if given an invalid id" do
      # Arrange - invalid id
      id = -1

      # Act
      get edit_book_path(id)

      # Assert
      must_respond_with :not_found
      expect(flash[:danger]).must_equal "Cannot find the book -1"
    end

  end
end
