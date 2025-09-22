# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Admin.destroy_all
Bibliotecario.destroy_all
Emprestimo.destroy_all
Livro.destroy_all
Usuario.destroy_all
Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password123"
  admin.password_confirmation = "password123"
end

Bibliotecario.find_or_create_by!(email: "bibliotecario@example.com") do |bibliotecario|
  bibliotecario.nome = "bibliotecario"
  bibliotecario.password = "password123"
  bibliotecario.password_confirmation = "password123"
  bibliotecario.must_change_password = true
end

categoria = Categoria.find_or_create_by!(nome: "Romance")

Livro.find_or_create_by!(titulo: "Belo livro") do |livro|
  livro.autor = "Belo autor"
  livro.categoria_id = categoria.id
  livro.observacoes = "Belas Observações"
end

Usuario.find_or_create_by!(email: "usuario@example.com") do |bibliotecario|
  bibliotecario.name = "Usuario foda"
  bibliotecario.cpf = "123.456.789-10"
  bibliotecario.number = "(01) 92345-6789"
  bibliotecario.password = "f727s7ak"
  bibliotecario.password_confirmation = "f727s7ak"
end