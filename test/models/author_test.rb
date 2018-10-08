require "test_helper"

describe Author do
  let(:author) { Author.new }

  it "must be valid" do
    value(author).must_be :valid?
  end

  describe 'author_list' do
    it 'should return an array' do

      # Act
      authors = Author.author_list

      # Assert
      expect(authors).must_be_instance_of Array

      authors.each do |author_array|
        current_author = Author.find(author_array[1])
        author_name = author_array[0]
        expect(author_name).must_equal current_author.name
      end
    end

    it 'should return an empty array when there are no authors' do
      # Act
      Author.all.each do |author|
        author.books.each do |book|
          book.destroy
        end

        author.destroy
      end
      authors = Author.author_list

      # Assert
      expect(authors).must_be_instance_of Array
      expect(authors.length).must_equal 0

    end
  end

  describe 'first published' do
    # 1.  An author with one book
    # 2.  An author with multiple books
    # 3.  An author with no book
  end









end
