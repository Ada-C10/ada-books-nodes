require "test_helper"

describe Book do
  let(:book) { Book.new title: 'War and peace', author_id: Author.first.id, description: 'desc'}

  it "must be valid" do
    expect(book).must_be :valid?
  end
end
