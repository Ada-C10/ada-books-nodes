require "test_helper"

describe Book do
  let(:book) { Book.new }

  it "must be valid" do
    value(book).must_be :valid?
  end
end
