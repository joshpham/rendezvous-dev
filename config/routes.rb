require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq'

  resources :messages
  resources :phone_numbers
  resources :phone_lists

  root to: 'static_pages#home'

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users

	 resources :phone_verifications
		post 'phone_verifications/verify_from_message' => 'phone_verifications#verify_from_message'

		resources :suggesteds
  resources :payments, only: [:new_gold, :new_platinum, :new_diamond, :create, :plans]

  get 'payments/plans', to: 'payments#plans'
  get 'payments/new_gold', to: 'payments#new_gold'
  get 'payments/new_platinum', to: 'payments#new_platinum'
  get 'payments/new_diamond', to: 'payments#new_diamond'


  get 'businesses/start', to: 'businesses#start'
  get '/about', to: 'static_pages#about'
  get '/businesses', to: 'businesses#index'
  get '/:id', to: 'static_pages#show'
  get '/:id', to: 'businesses#edit'


  resources :businesses do
				resources :phone_lists do
		    resources :phone_numbers 
				end
  end
 


end
