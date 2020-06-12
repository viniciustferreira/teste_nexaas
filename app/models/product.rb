class Product < ActiveRecord::Base
  has_many :stock_items, dependent: :destroy
  has_many :store , through: :stock_items
end