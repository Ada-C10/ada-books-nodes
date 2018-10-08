require "test_helper"

describe Book do
  let(:book) { books(:poodr)  }

  it "must be valid" do
    expect(book).must_be :valid?
  end

  it 'has required fields' do
    fields = [:title, :author, :description, :date_published]

    fields.each do |field|
      expect(book).must_respond_to field
    end
  end

  describe 'Relationships' do
    it 'belongs to an author' do
      # Arrange (done with let)

      # Act
      author = book.author

      # Assert
      expect(author).must_be_instance_of Author
      expect(author.id).must_equal book.author_id
    end

    it 'can have many genres' do
      # Arrange, did with let

      # Act
      book.genres << Genre.first
      genres = book.genres


      # Assert
      expect(genres.length).must_be :>=, 1
      genres.each do |genre|
        expect(genre).must_be_instance_of Genre
      end
    end
  end

  describe 'validations' do
    it 'must have a title' do
      # Arrange
      book = books(:detective_book)
      book.title = nil

      # Act
      #valid = book.valid?
      valid = book.save

      # Assert
      expect(valid).must_equal false
      expect(book.errors.messages).must_include :title
      expect(book.errors.messages[:title]).must_equal ["can't be blank", "is too short (minimum is 5 characters)"]
    end

    it 'must have a title with a min of 5 letters' do
      book.title = ''
      4.times do
        # Arrange
        book.title += 'a'

        # Act
        valid = book.valid?

        # Assert
        expect(valid).must_equal false
        expect(book.errors.messages).must_include :title
      end

      book.title += 'a'
      valid = book.valid?
      expect(valid).must_equal true
    end

    it 'requires a unique title' do
      #other_book = book.clone
      other_book = books(:detective_book)
      other_book.title = book.title

      valid = other_book.valid?

      expect(valid).must_equal false
      expect(other_book.errors.messages).must_include :title
    end
  end










end
