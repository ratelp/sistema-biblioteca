class AddDevolvidoToEmprestimo < ActiveRecord::Migration[8.0]
  def change
    add_column :emprestimos, :devolvido, :boolean, default: false
  end
end
