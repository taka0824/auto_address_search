Rails.application.routes.draw do

  get 'practices/search_box' => 'practices#search_box', as: 'practices_search_box'
  get 'practices/search' => 'practices#search', as: 'practices_search'


  devise_for :users

  root "homes#top"
  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :entries, only: [:create]
  resources :rooms, only: [:index, :create, :show]
  resources :messages, only: [:create, :edit, :update, :destroy]

  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' =>'relationships#followers', as: 'followers'
  end
  get 'search' => 'searches#search'
  get 'home/about' => "homes#about"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end