class Supplier < ApplicationRecord
  has_many :purchase_records
  has_many :supplier_products
  has_many :products, through: :supplier_products

  validates :name, presence: true
  validates :tel, presence: true

end
