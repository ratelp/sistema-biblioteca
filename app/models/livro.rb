class Livro < ApplicationRecord
  belongs_to :categoria

  enum :status, { disponivel: 0, emprestado: 1 }, default: :disponivel

  has_many :emprestimos, dependent: :destroy

  validates :observacoes, length: { maximum: 300 }
end
