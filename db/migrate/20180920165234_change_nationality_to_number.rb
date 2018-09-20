class ChangeNationalityToNumber < ActiveRecord::Migration[5.2]
  def change
    change_column :authors, :nationality, :integer, using: "nationality::integer"
  end
end
