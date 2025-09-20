class RegistrationsController < Devise::RegistrationsController
  before_action :ensure_password_changed_allowed, only: [:edit, :update]

  def update
    super do |resource|
      if resource.errors.empty? && resource.previous_changes["encrypted_password"].present?
        resource.update_column(:must_change_password, false)
      end
    end

  end

  protected

  def update_resource(resource, params)
    resource.update(params)
  end

  def after_update_path_for(resource)
    root_path
  end

  def ensure_password_changed_allowed
    if bibliotecario_signed_in? && !current_bibliotecario.must_change_password?
      redirect_to root_path, alert: "Você já fez a mudança de senha"
    end
  end

end

