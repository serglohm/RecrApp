Rails.application.routes.draw do

  resources :sources
  resources :skills
  resources :companies
  resources :candidates
  resources :vacancies

  resources :events do
    get :set_done, to: 'events#set_done'
    get :set_cancelled, to: 'events#set_cancelled'
  end

  resources :assignments, only: :destroy do
    match :set_hired, to: 'assignments#set_hired', via: :patch
    match :set_rejected, to: 'assignments#set_rejected', via: :patch
    match :set_withdrawn, to: 'assignments#set_withdrawn', via: :patch
    get :reset_status, to: 'assignments#reset_status'
    get :hire, to: 'assignments#hire_modal', as: 'hire_modal'
    get :reject, to: 'assignments#reject_modal', as: 'reject_modal'
    get :withdrawn, to: 'assignments#withdrawn_modal', as: 'withdrawn_modal'
  end

  devise_for :users
  resources :users

  get 'results', to: 'results#index', as: 'results'
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get "/uploads/candidate/resume/:id/:basename.:extension", controller: "candidates", action: "download"
  get :send_resume, controller: "candidates", action: "send_resume"
  get :create_telegraph_account, controller: "users", action: "create_telegraph_account"
  get :delete_telegraph_account, controller: "users", action: "delete_telegraph_account"
  get :create_telegraph_page, controller: "vacancies", action: "create_vacancy_on_telegraph"
  root "dashboard#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
