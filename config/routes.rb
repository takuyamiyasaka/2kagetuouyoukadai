Rails.application.routes.draw do
  devise_for :users
  root  "users#top"
  get "home/about"=>"users#about", as:"abouts"
  resources :users
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
