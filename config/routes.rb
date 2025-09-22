Rails.application.routes.draw do
  devise_for :usuarios, skip: [ :sessions, :registrations, :passwords ]

  resources :usuarios, only: [ :new, :create, :index, :show ]
  resources :categorias

  resources :livros do
    resources :emprestimos, only: [ :new, :create ]
  end

  # utilizando login unificado entre usuarios e administradores
  get "login", to:  "sessions#new"
  post "login", to:  "sessions#create"
  delete "logout", to:  "sessions#destroy"

  devise_for :bibliotecarios, skip: [ :sessions ], controllers: {
    passwords: "passwords",
    registrations: "registrations"
  }
  resources :bibliotecarios, only: [ :index, :new, :create, :destroy ]

  # para alteração de senha no primeiro login
  as :bibliotecario do
    get   "bibliotecarios/senhaEdit" => "registrations#edit",   as: :edit_bibliotecario_registration
    patch "bibliotecarios"      => "registrations#update", as: :bibliotecario_registration
    put   "bibliotecarios"      => "registrations#update"
  end

  devise_for :admin, skip: [ :sessions, :registrations, :passwords ]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "home#index"
end
