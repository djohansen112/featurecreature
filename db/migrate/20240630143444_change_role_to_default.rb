class ChangeRoleToDefault < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :role_id, :integer, default: '0'
  end
end
