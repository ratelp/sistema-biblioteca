class UsuariosController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @usuario = Usuario.new
  end

  def create

    random_password = Devise.friendly_token.first(12)

    @usuario = Usuario.new(usuario_params)
    @usuario.password = random_password
    @usuario.password_confirmation = random_password

    if @usuario.save
      UsuarioMailer.with(user: @usuario, password: random_password).welcome_email.deliver_later
      redirect_to root_path, notice: "usuario foi criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def usuario_params
    params.require(:usuario).permit(:email, :name, :cpf, :number)
  end
end
