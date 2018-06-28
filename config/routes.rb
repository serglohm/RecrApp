Rails.application.routes.draw do

  resources :comments, only: [:new, :create, :destroy]
  resources :sources
  resources :skills
  resources :companies
  resources :candidates
  resources :vacancies

  resources :chats do
    resources :chat_messages, only: [:show, :edit, :update], as: :messages do
      get :send_message, to: "chat_messages#send_message", as: 'send'
    end
  end

  resources :events do
    get :set_done, to: 'events#set_done'
    get :set_cancelled, to: 'events#set_cancelled'
  end

  resources :assignments, only: :destroy do
    match :set_hired, to: 'assignments#set_hired', via: :patch
    match :set_rejected, to: 'assignments#set_rejected', via: :patch
    match :set_withdrawn, to: 'assignments#set_withdrawn', via: :patch
    match :set_offer_rejected, to: 'assignments#set_offer_rejected', via: :patch


    get :set_invoiced, to: 'assignments#set_invoiced'
    get :reset_status, to: 'assignments#reset_status'

    get :hire, to: 'assignments#hire_modal', as: 'hire_modal'
    get :reject, to: 'assignments#reject_modal', as: 'reject_modal'
    get :withdrawn, to: 'assignments#withdrawn_modal', as: 'withdrawn_modal'
    get :offer_rejected, to: 'assignments#offer_rejected_modal', as: 'offer_rejected_modal'
  end

  scope :reports do
    get :candidates_by_users, to: 'reports#candidates_by_users'
    get :candidates_by_sources, to: 'reports#candidates_by_sources'
    get :candidates_by_months, to: 'reports#candidates_by_months'
    get :rejects_by_companies, to: 'reports#rejects_by_companies'
    get :offers_by_users, to: 'reports#offers_by_users'
  end

  devise_for :users
  resources :users
  get 'results', to: 'results#index', as: 'results'
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get "/uploads/candidate/resume/:id/:basename.:extension", to: "candidates#download"
  get :send_resume, to: "candidates#send_resume"
  get :export_to_xlsx, to: "candidates#export_to_xlsx"
  get :create_telegraph_account, to: "users#create_telegraph_account"
  get :delete_telegraph_account, to: "users#delete_telegraph_account"
  get :create_telegraph_page, to: "vacancies#create_vacancy_on_telegraph"
  root "dashboard#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
