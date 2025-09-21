class Emprestimo < ApplicationRecord
  belongs_to :livro
  belongs_to :usuario

  def data_devolucao
    (created_at + 15.days).to_date
  end
end
