class Emprestimo < ApplicationRecord
  belongs_to :livro
  belongs_to :usuario

  scope :ativos, -> { where(devolvido: false) }

  validate :livro_deve_estar_disponivel, on: :create
  validate :usuario_deve_estar_disponivel, on: :create

  before_create :set_due_date

  def livro_deve_estar_disponivel
    if livro.emprestado?
      errors.add(:livro, "já está emprestado")
    end
  end

  def usuario_deve_estar_disponivel
    if usuario.emprestimos.ativos.exists?
      errors.add(:usuario, "já possui livro emprestado")
    end
  end

  def set_due_date
    self.data_devolucao ||= 15.days.from_now.to_date
  end
end
