class EmprestimosController < ApplicationController
  before_action :set_livro, only: [ :new, :create ]

  def new
    @emprestimo = Emprestimo.new
  end

  def create
    @emprestimo = Emprestimo.new(emprestimo_params)

    respond_to do |format|
      if @emprestimo.save
        format.html { redirect_to @emprestimo, notice: "Emprestimo was successfully created." }
        format.json { render :show, status: :created, location: @emprestimo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @emprestimo.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_livro
    @livro = Livro.find(params[:livro_id])
  end

  def emprestimo_params
    params.expect(emprestimo: [:livro_id, :usuario_id])
  end
end
