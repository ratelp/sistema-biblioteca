class Categoria < ApplicationRecord
  has_many :livros, dependent: :destroy
end
