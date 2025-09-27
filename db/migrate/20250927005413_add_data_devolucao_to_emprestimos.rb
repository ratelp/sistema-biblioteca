class AddDataDevolucaoToEmprestimos < ActiveRecord::Migration[8.0]
  def change
    add_column :emprestimos, :data_devolucao, :date
  end
end
