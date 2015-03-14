class AddParentToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :parent, :string
  end
end
