class CreateShoppingItems < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_items do |t|
      t.references :user, foreign_key: true, index: true, on_delete: :cascade
      t.string :item
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
