# Sistema Biblioteca

## 🔎 Objetivo do Projeto

O **sistema de bibliotecas** foi desenvolvido para o desafio de seleção de estagiário da Prefeitura, tem como objetivo disponibilizar uma plataforma que simula uma biblioteca com empréstimo de livros para usuários cadastrados no sistema.

## ⚡ Tecnologias Utilizadas

- **Linguagem:** Ruby `3.4.5`
- **Framework:** Ruby on Rails `8.0.2.1`
- **Banco de Dados:** PostgreSQL `16.10`
- **Autenticação:** Devise `4.9.4`
- **Gerenciamento de Variáveis de Ambiente:** dotenv-rails `3.1.8`
- **Agendamento de Tarefas (Rake):** Whenever `1.0.0`

## 🛠️ Instruções de Setup 

```bash
git clone https://github.com/ratelp/sistema-biblioteca.git

cd sistema-biblioteca

bundle install

# Após instalação do sistema é necessário criar um arquivo '.env' 
# na raiz do projeto seguindo exemplo listado em '.env.example'

rails db:create
rails db:migrate
rails db:seed

rails s
```

### 🔐 Credenciais iniciais

- **Administrador:**
  - **Email:** admin@example.com
  - **Senha:** password123

- **Bibliotecario:**
  - **Email:** bibliotecario@example.com
  - **Senha:** password123

- **Bibliotecario:**
  - **Email:** ana.silva@example.com
  - **Senha:** password123

- **Usuário Comum:**
  - **CPF:** 111.222.333-44
  - **Senha:** 1FKaMddiqNXr

- **Usuário Comum:**
  - **CPF:** 222.333.444-55
  - **Senha:** zjq66iCz4sGm

- **Usuário Comum:**
  - **CPF:** 333.444.555-66
  - **Senha:** asdh12jaJnjk

Usuários comuns não fazem acesso ao sistema, as credenciais mencionadas são utilizadas para cadastro do empréstimo.