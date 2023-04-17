class CreatePurchaseRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_records do |t|
      t.date :purchase_date
      t.integer :quantity
      t.bigint :product_id
      t.bigint :supplier_id

      t.timestamps
    end
  end
end
