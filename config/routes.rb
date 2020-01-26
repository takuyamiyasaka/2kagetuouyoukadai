Rails.application.routes.draw do
  devise_for :users
  root  "users#top"
  get "home/about"=>"users#about", as:"abouts"
  resources :users
  resources :books do
  	resources :post_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
