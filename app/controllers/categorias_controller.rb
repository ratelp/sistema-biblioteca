class CategoriasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categoria, only: %i[ show edit update destroy ]

  # GET /categorias or /categorias.json
  def index
    query = Categoria.order(:nome)

    if params[:search].present?
      query = query.where("nome ILIKE ?", "%#{params[:search]}%")
    end

    @categorias = query
  end

  # GET /categorias/1 or /categorias/1.json
  def show
    @livros = @categoria.livros
  end

  # GET /categorias/new
  def new
    @categoria = Categoria.new
  end

  # GET /categorias/1/edit
  def edit
  end

  # POST /categorias or /categorias.json
  def create
    @categoria = Categoria.new(categoria_params)

    respond_to do |format|
      if @categoria.save
        format.html { redirect_to @categoria, notice: "Categoria was successfully created." }
        format.json { render :show, status: :created, location: @categoria }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categorias/1 or /categorias/1.json
  def update
    respond_to do |format|
      if @categoria.update(categoria_params)
        format.html { redirect_to @categoria, notice: "Categoria was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @categoria }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categorias/1 or /categorias/1.json
  def destroy
    @categoria.destroy!

    respond_to do |format|
      format.html { redirect_to categorias_path, notice: "Categoria was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categoria
      @categoria = Categoria.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def categoria_params
      params.expect(categoria: [ :nome ])
    end
end
