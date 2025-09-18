class MakeNomeNotNullInCategoria < ActiveRecord::Migration[8.0]
  def change
    change_column_null :categoria, :nome, false
    change_column_null :livros, :autor, false
    change_column_null :livros, :titulo, false
    change_column_null :livros, :autor, false

    change_column :livros, :status, :integer,  using: 'status::integer', default: 0, null: false
  end
end