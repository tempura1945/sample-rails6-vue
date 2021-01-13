# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }
  devise_scope :admin do
    get 'sign_in', to: 'admins/sessions#new'
    get 'sign_out', to: 'admins/sessions#destroy'
  end

  unauthenticated :admin do
    get 'admin' => redirect('/admin/sign_in')
  end
  namespace :admin, module: :admins do
    authenticated :admin do
      root to: 'dashboard#index'
      get 'dashboard/test'

      get    'memos/index'
      post   'memos',      to: 'memos#create'
      get    'memos/:id',  to: 'memos#show'
      put    'memos/:id',  to: 'memos#update'
      delete 'memos/:id',  to: 'memos#destroy'
    end
  end
  namespace 'api' do
    namespace 'v1' do
      authenticated :admin do
        resources :memos
      end
    end
  end

  root to: 'top#index'
end
