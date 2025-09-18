class AddNomeToBibliotecarios < ActiveRecord::Migration[8.0]
  def change
    add_column :bibliotecarios, :nome, :string
  end
end
