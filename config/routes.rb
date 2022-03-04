Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, except: [:create]
  get 'confirm' => 'users#confirm'
  resources :courses, only: [:index]
  resources :records, except: [:index]
  delete '/record_images/:id' => 'record_images#delete'
end
