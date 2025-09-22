class Emprestimo < ApplicationRecord
  belongs_to :livro
  belongs_to :usuario

  validate :livro_deve_estar_disponivel, on: :create

  def data_devolucao
    date = created_at
    days_added = 0

    while days_added < 15
      date += 1.day
      days_added += 1 unless date.saturday? || date.sunday?
    end

    date.to_date
  end

  def livro_deve_estar_disponivel
    if livro.emprestimos.unscope(where: :devolvido).where(devolvido: false).exists?
      errors.add(:livro, "já está emprestado")
    end
  end
end
