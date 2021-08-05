class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pagy::Backend

  before_action :authenticate_user!
end
