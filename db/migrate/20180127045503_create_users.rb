class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :remember_digest
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :city
      t.string :state
      t.string :country
      t.string :title
      t.integer :level
      t.integer :exp
      t.json :avatar
      t.timestamps
    end
  end
end
