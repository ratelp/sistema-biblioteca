Rails.application.routes.draw do
  root to: "livros#index"

  devise_for :usuarios, skip: [ :sessions, :registrations, :passwords ]

  resources :usuarios, only: [ :new, :create, :index, :show ]
  resources :categorias

  resources :livros do
    resources :emprestimos, only: [ :new, :create ] do
      member do
        patch :devolver
        patch :renovar
      end
    end
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

  get "up" => "rails/health#show", as: :rails_health_check
end
