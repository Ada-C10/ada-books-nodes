class AddNationalityToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :nationality, :string
  end
end
