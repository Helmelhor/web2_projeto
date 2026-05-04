class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quadra, null: false, foreign_key: true
      t.text :texto, null: false
      t.integer :nota, null: false
      t.timestamps null: false
    end
  end
end
