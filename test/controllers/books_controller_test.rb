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

    it "can get the form with the new_author_book_path" do
      # Arrange
      id = authors(:jordan).id

      # Act
      get new_author_book_path(id)

      # Assert
      must_respond_with :success
    end
    it "must respond with success for an invalid author id" do
      # Arrange
      id = -1

      # Act
      get new_author_book_path(id)

      # Assert
      must_respond_with :success
      expect(flash[:warning]).must_equal "That author doesn't exit"
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
      expect(response).must_be :not_found?
      must_respond_with :not_found
      expect(flash[:danger]).must_equal "Cannot find the book -1"
    end

  end

  describe "destroy" do
    it "can destroy a book given a valid id" do
      # Arrange
      id = books(:poodr).id
      title = books(:poodr).title

      # Act - Assert
      expect {
        delete book_path(id)
      }.must_change 'Book.count', -1

      must_respond_with :redirect
      expect(flash[:success]).must_equal "#{title} deleted"
      expect(Book.find_by(id: id)).must_equal nil
    end
  end




















end
