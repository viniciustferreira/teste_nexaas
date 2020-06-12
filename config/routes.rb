Rails.application.routes.draw do
  mount ProductAPI::API => '/v1/product_api/'
  mount StoreAPI::API => '/v1/store_api/'
  mount StockItemAPI::API => '/v1/stock_item_api/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
