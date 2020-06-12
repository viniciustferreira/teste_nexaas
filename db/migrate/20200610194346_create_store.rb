class CreateStore < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name, require: true
      t.string :address, require: true
      t.timestamps
    end
  end
end
