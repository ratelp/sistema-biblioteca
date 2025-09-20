class SessionsController < ApplicationController
  before_action :verify_user_is_logged_in, only: [ :new ]

  def new
  end

  def create
    role_class = params[:role].constantize
    user = role_class.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      sign_in(role_class.name.underscore.to_sym, user)
      wich_path(user)
    else
      redirect_to login_path, alert: "Senha ou email inválidos"
    end
  end

  def destroy
    sign_out(current_user_type) if user_signed_in?
    redirect_to login_path, notice: "Deslogado com sucesso"
  end

  def wich_path(user)
    if user.is_a?(Bibliotecario) && user.must_change_password == true
      redirect_to edit_bibliotecario_registration_path, notice: "Primeiro login, faça mudança de senha"; return
    end
    redirect_to root_path, notice: "Logado com sucesso"
  end

  def verify_user_is_logged_in
    if current_user
      redirect_to root_path, notice: "Já está logado"
    end
  end
end
