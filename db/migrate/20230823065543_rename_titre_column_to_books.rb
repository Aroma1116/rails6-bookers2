class RenameTitreColumnToBooks < ActiveRecord::Migration[6.1]
  def change
    rename_column :books, :titel, :title
  end
end
