class AddMustChangePasswordToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :bibliotecarios, :must_change_password, :boolean, default: true, null: false
  end
end
