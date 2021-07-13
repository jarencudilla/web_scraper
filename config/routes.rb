# frozen_string_literal: true

Rails.application.routes.draw do
  resources :vehicles do
    match '/scrape', to: 'vehicles#scrape', via: :post, on: :collection
  end

  root to: 'vehicles#index'



  # resources :products do
  #   match '/scrape', to: 'products#scrape', via: :post, on: :collection
  # end

  # root to: 'products#index'
end
