class ModifyLevelExpUsers < ActiveRecord::Migration[5.1]
  def change
  remove_column :users, :level
  remove_column :users, :exp
  add_column :users, :level, :integer, default:1
  add_column :users, :exp, :integer, default: 0
  end
end
