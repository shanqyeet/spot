class CreateThings < ActiveRecord::Migration[5.1]
  def change
    create_table :things do |t|
      t.references :user, foreign_key: true,index: true, on_delete: :cascade
      t.references :category, foreign_key: true,index: true, on_delete: :cascade
      t.string :name
      t.string :currency
      t.float :price
      t.string :unit
      t.string :vendor
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.float :longitude
      t.float :latitude
      t.timestamps
    end
  end
end
