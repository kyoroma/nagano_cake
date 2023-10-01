Rails.application.routes.draw do
  namespace :public do

    resources :items, only: [:index, :show], controller: 'items'

    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end

    resources :orders do
      collection do
        post 'confirm_order'
        get 'order_completed'
        post 'place_order'
      end
    end

    resources :customers, only: [:edit, :update] do
      member do
        get 'confirm_deactivation'
        patch 'deactivate'
      end
      get 'edit', on: :member
    end

    get 'my_page', to: 'customers#my_page', as: 'customer_my_page'
    get 'homes/top', to: 'homes#top', as: 'home_top'
    get 'homes/about', to: 'homes#about', as: 'home_about'
  end

  get '/about', to: 'static_pages#about', as: 'public_about'

  devise_for :customers, skip: [:passwords], controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'homes#top'
    resources :items, except: [:destroy]
    resources :orders, only: [:show]
    resources :customers, only: [:index, :show, :edit]
    delete '/sign_out', to: 'sessions#destroy', as: :destroy_admin_session
  end

  root to: 'public/homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
