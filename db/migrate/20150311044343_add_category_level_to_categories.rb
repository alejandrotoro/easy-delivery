class AddCategoryLevelToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :level, :integer
  end
end
