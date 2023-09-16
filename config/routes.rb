Rails.application.routes.draw do

  namespace :public do
    get 'homes/top'
    get 'homes/about'
    get '/about', to: 'static_pages#about', as: 'about'
  end
  devise_for :customers, skip: [:passwords], controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'homes#top'
    resources :items
    resources :orders, only: [:show]
    resources :customers, only: [:index, :show, :edit]
    delete '/sign_out', to: 'sessions#destroy', as: :destroy_admin_session
  end

  namespace :customer do
    resources :items
  end

  root to: 'admin/homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
