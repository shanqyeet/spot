class ThingsAddExp < ActiveRecord::Migration[5.1]
  def change
    add_column :things, :allocated_exp, :integer, default: 1
  end
end
