class AllowNullNotaInComments < ActiveRecord::Migration[8.0]
  def change
    # Altera a coluna :nota na tabela :comments para aceitar valores nulos (true)
    change_column_null :comments, :nota, true
  end
end
