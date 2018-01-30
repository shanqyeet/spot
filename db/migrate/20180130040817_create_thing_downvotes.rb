class CreateThingDownvotes < ActiveRecord::Migration[5.1]
  def change
    create_table :thing_downvotes do |t|
      t.references :user, foreign_key: true, index: true, on_delete: :cascade
      t.references :thing, foreign_key: true, index: true, on_delete: :cascade 
      t.timestamps
    end
  end
end
