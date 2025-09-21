class Emprestimo < ApplicationRecord
  belongs_to :livro
  belongs_to :usuario

  validate :livro_deve_estar_disponivel, on: :create

  def data_devolucao
    (created_at + 15.days).to_date
  end

  def livro_deve_estar_disponivel
    if livro.emprestimos.unscope(where: :devolvido).where(devolvido: false).exists?
      errors.add(:livro, "já está emprestado")
    end
  end
end
