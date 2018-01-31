class ShoppingItem < ApplicationRecord
  belongs_to :user
  enum status: ["Unchecked", "Checked"]
end
