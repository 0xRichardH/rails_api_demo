Rails.application.routes.draw do
  scope :v1 do
    mount_devise_token_auth_for "User", at: "auth"
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    resources :posts, only: [:index, :show, :create, :update, :destroy] do
      resources :comments, only: [:index, :create, :destroy], module: :post
    end
  end
end
