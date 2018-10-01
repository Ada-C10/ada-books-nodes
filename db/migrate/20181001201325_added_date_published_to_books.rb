class AddedDatePublishedToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :date_published, :datetime
  end
end
