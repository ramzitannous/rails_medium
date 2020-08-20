# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :users, only: %i[create index]
    post 'users/login', to: 'users#login'
    get 'users/me', to: 'users#me'

    resources :articles, only: %i[create index]
    get 'articles/me', to: 'articles#me'
  end
end
