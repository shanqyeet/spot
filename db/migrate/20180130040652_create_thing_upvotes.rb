class CreateThingUpvotes < ActiveRecord::Migration[5.1]
  def change
    create_table :thing_upvotes do |t|
      t.references :user, foreign_key: true, index: true, on_delete: :cascade
      t.references :thing, foreign_key: true, index: true, on_delete: :cascade 
      t.timestamps
    end
  end
end
