class CreateIntercommunalities < ActiveRecord::Migration[7.0]
  def change
   create_table :intercommunalities do |t|
      t.string :name
      t.string :siren, limit: 9
      t.string :form

      t.timestamps
    end
    add_index :intercommunalities, :siren, unique: true
  end
end
