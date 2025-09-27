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

  def marcar_como_devolvido!
    transaction do
      update!(devolvido: true)
      livro.update!(status: :disponivel)
    end
  end

  def calculate_due_date
    date = Date.today
    days_added = 0

    while days_added < 15
      date += 1.day
      days_added += 1 unless date.saturday? || date.sunday?
    end
  
    date.to_date
  end

  def renovar!
    update!(data_devolucao: calculate_due_date)
  end

  def set_due_date
    self.data_devolucao ||= calculate_due_date
  end
end
