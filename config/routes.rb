Rails.application.routes.draw do

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  resources :sources
  resources :skills
  resources :companies
  resources :candidates
  resources :vacancies
  devise_for :users
  resources :users
  get "/uploads/candidate/resume/:id/:basename.:extension", controller: "candidates", action: "download"
  get :send_resume, controller: "candidates", action: "send_resume"
  get :create_telegraph_account, controller: "users", action: "create_telegraph_account"
  get :delete_telegraph_account, controller: "users", action: "delete_telegraph_account"
  get :create_telegraph_page, controller: "vacancies", action: "create_vacancy_on_telegraph"
  root "candidates#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
