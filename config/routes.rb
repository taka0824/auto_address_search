Rails.application.routes.draw do
  devise_for :users
  root "homes#top"
  post "follow/:id" => "relationships#follow", as: "follow"
  post "unfollow/:id" => "relationships#unfollow", as: "unfollow"


  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :index, :edit, :update] do
    member do
      get :follower, :followed
    end
  end

  get 'home/about' => "homes#about"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end