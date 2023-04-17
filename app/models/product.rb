class Product < ApplicationRecord
  has_many :supplier_products
  has_many :purchase_records
  has_many :suppliers, through: :supplier_products

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }

end
