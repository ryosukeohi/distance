Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, except: [:create]
  get 'confirm' => 'users#confirm'
  resources :courses do
    resources :course_comments, only: [:create, :destroy]
  end
  get 'mycourse' => 'courses#mycourse'
  resources :records, except: [:index]
  resources :record_images, only: [:destroy]
  get 'search' => 'searches#search'
end
