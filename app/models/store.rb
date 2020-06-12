class Store < ActiveRecord::Base
  has_many :stock_items, dependent: :destroy
  has_many :products , through: :stock_items 
end