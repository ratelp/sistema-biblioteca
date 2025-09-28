class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :emprestimos, dependent: :destroy

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true,
            format: { with: /\A\d{3}\.\d{3}\.\d{3}-\d{2}\z/, message: "deve estar no formato 000.000.000-00" }
  validates :number, presence: true,
            format: { with: /\A\(\d{2}\)\s\d{5}-\d{4}\z/, message: "deve estar no formato (00) 00000-0000" }
end
