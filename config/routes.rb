# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :locations do
    resources :items do
      resources :comments
    end
  end

  resources :item_searches, only: [:index]
end
