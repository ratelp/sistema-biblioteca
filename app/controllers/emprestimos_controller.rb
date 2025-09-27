class EmprestimosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_livro, only: [ :new, :create, :devolver, :renovar ]
  before_action :set_emprestimo, only: [ :devolver, :renovar ]

  def devolver
    if @emprestimo.marcar_como_devolvido!
      redirect_to usuario_path(@emprestimo.usuario), notice: "Livro devolvido com sucesso!"
    else
      redirect_to usuario_path(@emprestimo.usuario), notice: "Ocorreu erro ao devolver livro!"
    end
  end

  def renovar
    if @emprestimo.renovar!
      redirect_to usuario_path(@emprestimo.usuario), notice: "Livro renovado com sucesso!"
    else
      redirect_to usuario_path(@emprestimo.usuario), notice: "Ocorreu erro ao renovar livro!"
    end
  end

  def new
    @emprestimo = @livro.emprestimos.build
  end

  def create
    emprestimo = params[:emprestimo]
    @usuario = Usuario.find_by(cpf: emprestimo[:cpf])

    if @usuario&.valid_password?(emprestimo[:password])
      @emprestimo = @livro.emprestimos.build(usuario: @usuario)
      if @emprestimo.save
        @livro.emprestado!
        redirect_to @livro, notice: "Livro emprestado com sucesso!"
      else
        flash.now[:alert] = @emprestimo.errors.full_messages.to_sentence
        render :new, status: :unprocessable_entity
      end
    else
      @emprestimo = @livro.emprestimos.build
      flash.now[:alert] = "CPF ou senha incorretos."
      render :new, status: :unprocessable_entity
    end
  end

  def set_livro
    @livro = Livro.find(params[:livro_id])
  end


  def set_emprestimo
    @emprestimo = @livro.emprestimos.find(params[:id])
  end
end
