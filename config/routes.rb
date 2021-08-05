Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :posts, only: [:index, :show, :create, :update, :destroy] do
    resources :comments, only: [:index, :create, :destroy], module: :post
  end
end
