class SessionsController < ApplicationController
  def new
  end

  def create
    role_class = params[:role].constantize
    user = role_class.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      sign_in(role_class.name.underscore.to_sym, user)
      redirect_to root_path, notice: "Logado com sucesso"
    else
      redirect_to login_path, alert: "Senha ou email inválidos"
    end
  end

  def destroy
    sign_out(current_user_type) if user_signed_in?
    redirect_to login_path, notice: "Deslogado com sucesso"
  end
end
