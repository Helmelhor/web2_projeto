class CreateLikes < ActiveRecord::Migration[8.1]
  def change
    drop_table :likes, if_exists: true

    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :likeable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
