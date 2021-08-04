require "test_helper"

class UserTest < ActiveSupport::TestCase
  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:email)
    should allow_values("richard@digitalstar.tech").for(:email)
    should_not allow_values("digitalstar.tech").for(:email)
  end
end
