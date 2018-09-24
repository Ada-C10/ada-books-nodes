require 'test_helper'

describe BooksController do
  it "should get index" do
    get books_path
    expect(response).must_be :success?
  end

  describe "show" do
    it "will get show for valid ids" do
      id = books(:poodr).id

      get book_path(id)

      expect(response).must_be :success?
    end

    it "will respond with not_found for invalid ids" do
      id = books(:poodr)
      books(:poodr).destroy

      get book_path(id)

      expect(response).must_be :not_found?
    end
  end

  describe "new" do
    it "will load the new book page" do
      get new_book_path

      expect(response).must_be :success?
    end
  end

  describe "edit" do
    it "will load the edit page for valid ids" do
      id = books(:poodr).id

      get edit_book_path(id)

      expect(response).must_be :success?
    end

    it "will respond with not_found for invalid ids" do
      id = books(:poodr).id
      books(:poodr).destroy

      get edit_book_path(id)

      expect(response).must_be :not_found?
    end
  end

  describe "destroy" do
    it "can destroy a model" do
      expect {
        id = books(:poodr).id

        delete book_path(id)

        expect(response).must_be :success?
      }.must_change 'Book.count', -1
    end
  end

  describe "create" do
    it "can create a book" do
      book_hash = {
        title: 'A Wrinkle in Time',
        author: authors(:metz).id,
        description: 'A fabulous adventure'
      }

      expect {
        post books_path, params: book_hash
      }.must_change 'Book.count', 1
    end
  end
end
