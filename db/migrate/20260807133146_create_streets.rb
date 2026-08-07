class CreateStreets < ActiveRecord::Migration[7.0]
  def change
    create_table :streets do |t|
      t.string :title, null: false
      t.integer :from
      t.integer :to

      t.timestamps
    end
  end
end
