class CreateShoppingItems < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_items do |t|

      t.timestamps
    end
  end
end
