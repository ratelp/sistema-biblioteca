class BibliotecariosController < ApplicationController
  before_action :authenticate_user!
  before_action :only_administrador, only: [:index, :new, :create, :destroy]

  def index
    @page = params.fetch(:page, 1).to_i
    per_page = 6

    query = Bibliotecario.order(:email)

    if params[:search].present?
      query = query.where("email ILIKE ?", "%#{params[:search]}%")
    end

    @total_bibliotecarios = query.count
    @bibliotecarios = query.offset((@page - 1) * per_page).limit(per_page)
    @total_pages = (@total_bibliotecarios / per_page.to_f).ceil
  end

  def new
    @bibliotecario = Bibliotecario.new
  end

  def create
    @bibliotecario = Bibliotecario.new(bibliotecario_params)

    if @bibliotecario.save
      redirect_to bibliotecarios_path, notice: "Bibliotecario foi criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bibliotecario = Bibliotecario.find(params[:id])
    @bibliotecario.destroy
    redirect_to bibliotecarios_path, notice: "Excluído com sucesso"
  rescue ActiveRecord::RecordNotDestroyed
    redirect_to bibliotecarios_path, alert: "Exclusão de Usuário falhou"
  end

  def bibliotecario_params
    params.require(:bibliotecario).permit(:nome, :email, :password, :password_confirmation)
  end

  def only_administrador
    redirect_to root_path, alert: "Somente administrador pode acessar essa página" unless current_user_type == :admin
  end

end
