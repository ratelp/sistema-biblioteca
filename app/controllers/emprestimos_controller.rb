class EmprestimosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_livro, only: [ :new, :create ]

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
end
