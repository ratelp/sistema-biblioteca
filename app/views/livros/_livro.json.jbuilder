json.extract! livro, :id, :autor, :titulo, :categoria_id, :status, :observacoes, :created_at, :updated_at
json.url livro_url(livro, format: :json)
