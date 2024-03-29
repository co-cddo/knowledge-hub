# frozen_string_literal: true

require "sidekiq/web"
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  mount Sidekiq::Web => "/sidekiq"

  resources :locations do
    member do
      get :new_sub_location
      get :search, to: "item_searches#index"
    end

    resources :items do
      resources :comments
    end
  end

  resources :item_searches, only: [:index]
end
