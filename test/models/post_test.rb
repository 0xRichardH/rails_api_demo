require "test_helper"

class PostTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:author).class_name("User")
    should have_many(:comments).dependent(:destroy)
  end

  context "validations" do
    should validate_presence_of(:title)
    should validate_length_of(:title).is_at_most(255)
    should validate_presence_of(:body)
  end
end
