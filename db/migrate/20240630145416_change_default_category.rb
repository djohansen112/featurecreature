class ChangeDefaultCategory < ActiveRecord::Migration[7.1]
  def change
    change_column :categories, :category_id, :integer, default: '0'
  end
end
