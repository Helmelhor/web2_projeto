class CreateQuadras < ActiveRecord::Migration[7.0]
  def change
    create_table :quadras do |t|
      t.string :nome, null: false
      t.string :endereco, null: false
      t.string :cidade, null: false
      t.string :foto_url
      t.text :descricao
      t.string :tipo_piso
      t.boolean :tem_iluminacao, default: false
      t.timestamps null: false # criado em tal tal tal data e hora
    end
  end
end
