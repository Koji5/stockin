class Product < ApplicationRecord
  has_many :supplier_products
  has_many :purchase_records
  has_many :suppliers, through: :supplier_products
end
