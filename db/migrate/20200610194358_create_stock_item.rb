class CreateStockItem < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_items do |t|
      t.belongs_to :product
      t.belongs_to :store
      t.integer :quantity
      t.timestamps
    end
  end
end
