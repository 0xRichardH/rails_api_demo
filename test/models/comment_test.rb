require "test_helper"

class CommentTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to :user
    should belong_to :post
  end

  context "validations" do
    should validate_presence_of :body
    should validate_length_of(:body).is_at_least(10)
  end
end
