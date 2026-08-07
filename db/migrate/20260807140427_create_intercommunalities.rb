class CreateIntercommunalities < ActiveRecord::Migration[7.0]
  def change
   create_table :intercommunalities do |t|
      t.string :name, null: false
      t.string :siren, null: false, limit: 9
      t.string :form, null: false

      t.timestamps
    end
    add_index :intercommunalities, :siren, unique: true
  end
end
