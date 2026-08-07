class AddSlugToIntercommunality < ActiveRecord::Migration[7.0]
  def change
    add_column :intercommunalities, :slug, :string
  end
end
