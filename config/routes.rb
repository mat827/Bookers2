Rails.application.routes.draw do
root  "homes#index"

get "home/about" => "about#top"
devise_for :users


resources :users, only:[:index,:show,:edit,:update,:create,:update]
resources :books, only:[:index,:show,:edit,:update,:create,:destroy]


end
