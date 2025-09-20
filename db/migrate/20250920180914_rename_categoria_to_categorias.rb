class RenameCategoriaToCategorias < ActiveRecord::Migration[8.0]
  def change
    rename_table :categoria, :categorias
  end
end
