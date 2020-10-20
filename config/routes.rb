Rails.application.routes.draw do
  devise_for :users
  root "homes#top"
    resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' =>'relationships#followers', as: 'followers'
  end
  get 'search' => 'searches#search'
  get 'home/about' => "homes#about"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end