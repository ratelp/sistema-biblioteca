class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :user_signed_in?, :current_user, :current_user_type
  before_action :check_password_change


  def check_password_change
    return unless bibliotecario_signed_in?
    return if current_bibliotecario.must_change_password == false
    return if devise_controller?

    redirect_to edit_bibliotecario_registration_path,
      alert: "Necessário mudar a senha antes de continuar"
  end

  def user_signed_in? 
    admin_signed_in? || bibliotecario_signed_in? || usuario_signed_in?
  end

  def current_user
    return current_admin if admin_signed_in?
    return current_bibliotecario if bibliotecario_signed_in?
    return current_usuario if usuario_signed_in?
    nil
  end

  def current_user_type
  return :admin if admin_signed_in?
  return :bibliotecario if bibliotecario_signed_in?
  return :usuario if usuario_signed_in?
  nil
  end

  def authenticate_user!
    redirect_to login_path , alert: "Você precisa estar logado!" unless user_signed_in?
  end
end
