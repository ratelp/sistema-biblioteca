# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Limpando o banco de dados..."
Admin.destroy_all
Bibliotecario.destroy_all
Emprestimo.destroy_all
Livro.destroy_all
Usuario.destroy_all
Categoria.destroy_all

puts "Criando Admin..."
Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password123"
  admin.password_confirmation = "password123"
end

puts "Criando Bibliotecários..."
Bibliotecario.find_or_create_by!(email: "bibliotecario@example.com") do |bibliotecario|
  bibliotecario.nome = "Carlos"
  bibliotecario.password = "password123"
  bibliotecario.password_confirmation = "password123"
  bibliotecario.must_change_password = true
end

Bibliotecario.find_or_create_by!(email: "ana.silva@example.com") do |bibliotecario|
  bibliotecario.nome = "Ana Silva"
  bibliotecario.password = "password123"
  bibliotecario.password_confirmation = "password123"
  bibliotecario.must_change_password = true
end

puts "Criando Categorias..."
categorias = {}
[ "Ficção Científica", "Fantasia", "Romance", "Mistério", "Não-ficção", "Biografia" ].each do |nome_categoria|
  categorias[nome_categoria] = Categoria.create!(nome: nome_categoria)
end

puts "Criando Livros..."
Livro.create!([
  { titulo: "Duna", autor: "Frank Herbert", categoria: categorias["Ficção Científica"], observacoes: "Edição de colecionador." },
  { titulo: "Fundação", autor: "Isaac Asimov", categoria: categorias["Ficção Científica"] },
  { titulo: "O Senhor dos Anéis: A Sociedade do Anel", autor: "J.R.R. Tolkien", categoria: categorias["Fantasia"] },
  { titulo: "O Nome do Vento", autor: "Patrick Rothfuss", categoria: categorias["Fantasia"], observacoes: "Capa dura." },
  { titulo: "Orgulho e Preconceito", autor: "Jane Austen", categoria: categorias["Romance"] },
  { titulo: "O Amor nos Tempos do Cólera", autor: "Gabriel García Márquez", categoria: categorias["Romance"] },
  { titulo: "E Não Sobrou Nenhum", autor: "Agatha Christie", categoria: categorias["Mistério"] },
  { titulo: "Sapiens: Uma Breve História da Humanidade", autor: "Yuval Noah Harari", categoria: categorias["Não-ficção"] },
  { titulo: "Steve Jobs", autor: "Walter Isaacson", categoria: categorias["Biografia"] }
])

puts "Criando Usuários..."
usuario_com_emprestimo = Usuario.create!(
  name: "Mariana Costa",
  email: "mariana.costa@example.com",
  cpf: "111.222.333-44",
  number: "(11) 98877-6655",
  password: "1FKaMddiqNXr",
  password_confirmation: "1FKaMddiqNXr"
)

Usuario.create!([
  {
    name: "João Pereira",
    email: "joao.pereira@example.com",
    cpf: "222.333.444-55",
    number: "(21) 97766-5544",
    password: "zjq66iCz4sGm",
    password_confirmation: "zjq66iCz4sGm"
  },
  {
    name: "Beatriz Lima",
    email: "beatriz.lima@example.com",
    cpf: "333.444.555-66",
    number: "(31) 96655-4433",
    password: "asdh12jaJnjk",
    password_confirmation: "asdh12jaJnjk"
  }
])

puts "Criando um Empréstimo ativo..."
livro_para_emprestar = Livro.find_by(titulo: "Duna")
if livro_para_emprestar && usuario_com_emprestimo
  Emprestimo.create!(
    livro: livro_para_emprestar,
    usuario: usuario_com_emprestimo
  )
  livro_para_emprestar.emprestado!
end

puts "Seed concluído!"
