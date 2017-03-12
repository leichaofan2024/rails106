Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root "groups#index"
namespace :account do
  resources :posts
end
resources :groups do
  resources :posts
  collection do
    get :groupmember
    get :mypost
  end
  member do
    post :join
    post :people
  end
end
end
