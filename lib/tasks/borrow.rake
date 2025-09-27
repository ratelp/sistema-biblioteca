namespace :borrow do
  desc "Enviar e-mail para quando estiver próximo de expirar empréstimo"
  task daily_maintenance: :environment do
    today = Date.today

    Emprestimo.where(data_devolucao: today + 1.day).find_each do |borrow|
      UsuarioMailer.borrow_ending_warning(borrow).deliver_now
    end

    Emprestimo.where("data_devolucao < ? AND devolvido = ?", today, false).find_each do |borrow|
      Emprestimo.update!(devolvido: true)
    end
  end
end
