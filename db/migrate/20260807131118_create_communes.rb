class CreateCommunes < ActiveRecord::Migration[7.0]
  def change
    create_table :communes do |t|
      t.string :name, null: false
      t.string :code_insee, null: false, limit: 5
      t.references :intercommunality, foreign_key: true

      t.timestamps
    end
    add_index :communes, :code_insee, unique: true
  end
end
