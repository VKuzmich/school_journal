# == Route Map
#

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  root to: 'home#index'

  namespace :admin do
    resources :grades
    resources :subjects
    resources :teachers
    resources :parents
    resources :students
  end

  resources :lessons
  resources :journals
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
