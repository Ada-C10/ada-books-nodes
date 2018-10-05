require "test_helper"

describe Genre do
  let(:genre) { Genre.new }

  it "must be valid" do
    value(genre).must_be :valid?
  end
end
