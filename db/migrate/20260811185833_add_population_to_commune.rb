class AddPopulationToCommune < ActiveRecord::Migration[7.0]
  def change
    add_column :communes, :population, :integer
  end
end
