Rails.application.routes.draw do
  devise_for :users
  root  "users#top"
  get "home/about"=>"users#about", as:"abouts"
  post "follow/:id" =>"relations#create", as: "follow"
  post "unfollow/:id" => "relations#destroy", as: "unfollow"
  resources :users do
    member do
      get "follow"
      get "follower"
    end
  end
  resources :books do
  	resources :post_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
