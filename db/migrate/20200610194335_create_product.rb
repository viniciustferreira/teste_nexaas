class CreateProduct < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, require: true
      t.integer :cost, require: true
      t.string :description, require: true
      t.timestamps
    end
  end
end
