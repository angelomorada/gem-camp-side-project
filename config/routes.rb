Rails.application.routes.draw do

  constraints(ClientDomainConstraint.new) do
    get '/', to: 'client/home#index'
    devise_for :users, controllers: { sessions: 'client/sessions', registrations: 'client/registrations' } 
    namespace :client, path: '' do
      root 'home#index'
      resource :home
    end
  end

  constraints(AdminDomainConstraint.new) do
    get '/', to: 'admin/home#index'
    devise_for :users, as: 'admin', controllers: { sessions: 'admin/sessions', registrations: 'admin/registrations' }
    namespace :admin, path: '' do
      root 'home#index'
      resource :home
    end
  end

  namespace :api do
    namespace :v1 do
      resources :regions, only: %i[index show], defaults: { format: :json } do
        resources :provinces, only: :index, defaults: { format: :json }
      end

      resources :provinces, only: %i[index show], defaults: { format: :json } do
        resources :cities, only: :index, defaults: { format: :json }
      end

      resources :cities, only: %i[index show], defaults: { format: :json } do
        resources :barangays, only: :index, defaults: { format: :json }
      end

      resources :barangays, only: %i[index show], defaults: { format: :json }
    end
  end
end