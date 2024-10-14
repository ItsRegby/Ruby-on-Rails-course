class AddCategoryToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :category, foreign_key: true
  end
end
