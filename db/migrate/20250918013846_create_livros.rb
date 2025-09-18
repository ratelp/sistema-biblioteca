class CreateLivros < ActiveRecord::Migration[8.0]
  def change
    create_table :livros do |t|
      t.string :autor
      t.string :titulo
      t.references :categoria, null: false, foreign_key: true
      t.boolean :status
      t.text :observacoes

      t.timestamps
    end
  end
end
