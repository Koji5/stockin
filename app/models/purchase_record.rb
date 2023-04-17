class PurchaseRecord < ApplicationRecord
  belongs_to :product
  belongs_to :supplier

  validates :purchase_date, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

end
