require "test_helper"

describe Author do
  let(:author) { Author.new }

  it "must be valid" do
    value(author).must_be :valid?
  end
end
