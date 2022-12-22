Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "users/show" => "users#show"
  get "mypage" => "courses#index"
  get "otherpage" => "courses#all_index" 
  resources :courses, only: [:new, :create, :edit, :update, :destroy, :show, :index, :all_index]do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create] 
  end
  resources :relationships, only: [:create, :destroy]

end
