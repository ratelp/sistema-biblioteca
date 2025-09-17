class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :user_signed_in?, :current_user, :current_user_type


  def user_signed_in? 
    admin_signed_in? || bibliotecario_signed_in?
  end

  def current_user
    return current_admin if admin_signed_in?
    return current_bibliotecario if bibliotecario_signed_in?
    nil
  end

  def current_user_type
  return :admin if admin_signed_in?
  return :bibliotecario if bibliotecario_signed_in?
  nil
  end

  def authenticate_user!
    redirect_to login_path , alert: "Você precisa estar logado!" unless user_signed_in?
  end

end
