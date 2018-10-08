require "test_helper"

describe Book do
  let(:book) { Book.new title: 'War and peace', author_id: Author.first.id, description: 'desc'}

  it "must be valid" do
    expect(book).must_be :valid?
  end

  it "is invalid without an author" do
    book.author_id = nil

    expect(book.valid?).must_equal false
    expect(book.errors.messages).must_include :author
  end

  it "is invalid without a title" do
    book.title = nil

    expect(book.valid?).must_equal false
    expect(book.errors.messages).must_include :title
  end

  it "must have an author" do

    expect(book.author).must_be_instance_of Author
  end

  it "must have the required fields" do
    fields = [:title, :description, :author, :date_published]

    fields.each do |field|
      expect(book).must_respond_to field
    end
  end
end
