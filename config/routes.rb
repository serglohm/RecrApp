Rails.application.routes.draw do

  resources :sources
  resources :languages
  resources :companies
  resources :candidates
  resources :vacancies
  devise_for :users
  resources :users
  get "/uploads/candidate/resume/:id/:basename.:extension", controller: "candidates", action: "download"
  root "candidates#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
