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
        book: {
          title: 'A Wrinkle in Time',
          author_id: authors(:metz).id,
          description: 'A fabulous adventure'
        }
      }

      expect {
        post books_path, params: book_hash
        expect(response).must_be :redirect?
      }.must_change 'Book.count', 1

      expect(Book.last.title).must_equal book_hash[:book][:title]
      expect(Book.last.author_id).must_equal book_hash[:book][:author_id]
      expect(Book.last.description).must_equal book_hash[:book][:description]
    end

    it "will not create a book with invalid params" do
      book_hash = {
        book: {
          title: 'A Wrinkle in Time',
          author_id: Author.last.id + 1, # invalid author_id
          description: 'A fabulous adventure'
        }
      }

      expect {
        post books_path, params: book_hash
        expect(response).must_be :bad_request?
      }.wont_change 'Book.count'
    end
  end

  describe "update" do
    let (:book_hash) {
      {
            book: {
              title: 'A Wrinkle in Time',
              author_id: Author.last.id, # valid author_id
              description: 'A fabulous adventure'
            }
      }
    }
    it "will update a model with a valid post request" do
      id = books(:poodr).id
      expect {
        patch book_path(id), params: book_hash

        must_respond_with :redirect
      }.wont_change 'Book.count'
      book = Book.find_by(id: id)

      expect(book.title).must_equal book_hash[:book][:title]
      expect(book.author_id).must_equal book_hash[:book][:author_id]
      expect(book.description).must_equal book_hash[:book][:description]
    end

    it "will not update if the params are invalid" do
      id = books(:poodr).id
      original_book = books(:poodr)
      book_hash[:book][:author_id] = -1 # invalid id
      expect {
        patch book_path(id), params: book_hash

        must_respond_with :error
      }.wont_change 'Book.count'

      book = Book.find_by(id: id)

      expect(book.title).must_equal original_book.title
      expect(book.author_id).must_equal original_book.author_id
      expect(book.description).must_equal original_book.description
    end

    it "will respond with not_found for invalid ids" do
      id = -1

      expect {
        patch book_path(id), params: book_hash

        must_respond_with :not_found
      }.wont_change 'Book.count'
    end
  end
end
