Rails.application.routes.draw do
  namespace :public do
    resources :customers, only: [:edit, :update] do
      member do
        patch 'deactivate' 
      end
    end
    get 'customers/my_page'
    get 'customers/confirm_deactivation'
    get 'homes/top'
    get 'homes/about'
  end

  get '/about', to: 'public/static_pages#about', as: 'about'

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

  root to: 'public/homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
