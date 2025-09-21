class Livro < ApplicationRecord
  belongs_to :categoria

  enum :status , {disponivel: 0, emprestado: 1}, default: :disponivel

  has_one :emprestimo

  def categoria
    Categoria.find(categoria_id)
  end

end
