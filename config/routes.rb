Rails.application.routes.draw do

  resources :sources
  resources :skills
  resources :companies
  resources :candidates
  resources :vacancies
  devise_for :users
  resources :users
  get "/uploads/candidate/resume/:id/:basename.:extension", controller: "candidates", action: "download"
  get :send_resume, controller: "candidates", action: "send_resume"
  root "candidates#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
