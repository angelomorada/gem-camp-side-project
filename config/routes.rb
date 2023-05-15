Rails.application.routes.draw do

  constraints(ClientDomainConstraint.new) do
    devise_for :users, controllers: { sessions: 'client/sessions', registrations: 'client/registrations' } 
    namespace :client, path: '' do
      root 'home#index'
      resource :home
    end
  end

  constraints(AdminDomainConstraint.new) do
    devise_for :users, controllers: { sessions: 'admin/sessions' }
    namespace :admin, path: '' do
      root 'home#index'
      resource :home
    end
  end
end