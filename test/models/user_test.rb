require "test_helper"

class UserTest < ActiveSupport::TestCase
  context "associations" do
    should have_many :posts
    should have_many :comments
  end

  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:email)
    should validate_uniqueness_of(:email)
    should allow_values("richard@digitalstar.tech").for(:email)
    should_not allow_values("digitalstar.tech").for(:email)
  end
end
