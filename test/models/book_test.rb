require "test_helper"

describe Book do
  let(:book) { books(:poodr) }

  it "must be valid" do
    value(book).must_be :valid?
  end
end
