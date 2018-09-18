class Rename < ActiveRecord::Migration[5.2]
  def change
    rename_column :authors, :pulisher, :publisher
  end
end
