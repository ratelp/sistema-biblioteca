class UsuariosController < ApplicationController
  before_action :authenticate_user!

    def index
      @page = params.fetch(:page, 1).to_i
      per_page = 6

      query = Usuario.order(:cpf)

      if params[:search].present?
        numbers_only = params[:search].gsub(/\D/, '')
        query = query.where("regexp_replace(cpf, '[^0-9]', '', 'g') ILIKE ?", "%#{numbers_only}%")
      end

      @total_usuarios = query.count
      @usuarios = query.offset((@page - 1) * per_page).limit(per_page)
      @total_pages = (@total_usuarios / per_page.to_f).ceil
    end
  
  def show
    @usuario = Usuario.find(params.expect(:id))

    @emprestimo_atual = @usuario.emprestimos.order(created_at: :desc).first
  end

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
      redirect_to @usuario, notice: "usuario foi criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def usuario_params
    params.require(:usuario).permit(:email, :name, :cpf, :number)
  end
end
