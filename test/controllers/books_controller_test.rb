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
      must_redirect_to books_path
      expect(flash[:success]).must_equal "#{title} deleted"
      expect(Book.find_by(id: id)).must_equal nil
    end

    it "should respond with not_found for an invalid id" do
      id = -1

      # Equivalent
      # before_count = Book.count
      # delete book_path(id)
      # after_count = Book.count
      # expect(before_count).must_equal after_count

      expect {
        delete book_path(id)
        # }.must_change 'Book.count', 0
      }.wont_change 'Book.count'

      must_respond_with :not_found
      expect(flash.now[:danger]).must_equal "Cannot find the book #{id}"
    end
  end

  describe "create & update" do
    let (:book_hash) do
      {
        book: {
          title: 'White Teeth',
          author_id: authors(:galbraith).id,
          description: 'Good book'
        }
      }
    end


    describe "create" do
      it "can create a new book given valid params" do
        # Act-Assert
        expect {
          post books_path, params: book_hash
        }.must_change 'Book.count', 1

        must_respond_with :redirect
        must_redirect_to book_path(Book.last.id)

        expect(Book.last.title).must_equal book_hash[:book][:title]
        expect(Book.last.author).must_equal Author.find_by(id: book_hash[:book][:author_id])
        expect(Book.last.description).must_equal book_hash[:book][:description]

      end

      it "responds with an error for invalid params" do
        # Arranges
        book_hash[:book][:title] = nil

        # Act-Assert
        expect {
          post books_path, params: book_hash
        }.wont_change 'Book.count'

        must_respond_with :bad_request

      end
    end

    describe "update" do
      it "can update a model with valid params" do
        id = books(:poodr).id

        expect {
          patch book_path(id), params: book_hash
        }.wont_change 'Book.count'

        must_respond_with :redirect
        must_redirect_to book_path(id)

        new_book = Book.find_by(id: id)

        expect(new_book.title).must_equal book_hash[:book][:title]
        expect(new_book.author_id).must_equal book_hash[:book][:author_id]
        expect(new_book.description).must_equal book_hash[:book][:description]
      end
      it "gives an error if the book params are invalid" do
        # Arrange
        book_hash[:book][:title] = nil
        id = books(:poodr).id
        old_poodr = books(:poodr)


        expect {
          patch book_path(id), params: book_hash
        }.wont_change 'Book.count'
        new_poodr = Book.find(id)

        must_respond_with :bad_request
        expect(old_poodr.title).must_equal new_poodr.title
        expect(old_poodr.author_id).must_equal new_poodr.author_id
        expect(old_poodr.description).must_equal new_poodr.description
      end
      it "gives not_found for a book that doesn't exist" do
        id = -1

        expect {
          patch book_path(id), params: book_hash
        }.wont_change 'Book.count'

        must_respond_with :not_found

      end
    end



  end
















end
