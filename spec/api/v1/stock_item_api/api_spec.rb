require 'rails_helper'

RSpec.describe StockItemAPI::API do 
  describe 'POST /add_items?product_id=1&store_id=1&quantity=1', type: :api do
    it 'returns a 201 code for been updated' do
      product_on_stock = double(StockItem, id: 1, quantity: 1, product_id: 1) 
      products_on_stock = [ product_on_stock ]

      expect(StockItem).to receive(:where)
        .with({ product_id: 1, store_id: 1 })
        .and_return(products_on_stock)

      expect(product_on_stock).to receive(:update)
        .with(quantity: 2)
        .and_return(true)

      response_api = call_api
      expect(response_api.body).to eq("new quantity of product 1 is 2")
      expect(response_api.status).to eq(201)
    end
  end

  describe 'POST /add_items?product_id=1&store_id=1&quantity=1', type: :api do
    it 'returns a 500 code for not been updated' do
      product_on_stock = double(StockItem, id: 1, quantity: 1) 
      products_on_stock = [ product_on_stock ]

      expect(StockItem).to receive(:where)
        .with({ product_id: 1, store_id: 1 })
        .and_return(products_on_stock)

      expect(product_on_stock).to receive(:update)
        .with(quantity: 2)
        .and_return(false)

      response_api = call_api
      expect(response_api.body).to eq("quantity not updated")
      expect(response_api.status).to eq(500)
    end
  end

  describe 'POST /add_items?product_id=1&store_id=1&quantity=1', type: :api do
    it 'returns a 201 code for been created' do
      product_on_stock = double(StockItem, id: 1, quantity: 1, product_id: 1) 
      allow(product_on_stock).to receive(:persisted?)
        .and_return(true)

      expect(StockItem).to receive(:where)
        .with({ product_id: 1, store_id: 1 })
        .and_return([])

      expect(StockItem).to receive(:create)
        .with({ product_id: 1, store_id: 1, quantity: 1 })
        .and_return(product_on_stock)

      response_api = call_api
      expect(response_api.body).to eq("new product was added")
      expect(response_api.status).to eq(201)
    end
  end

  describe 'POST /add_items?product_id=1&store_id=1&quantity=1', type: :api do
    it 'returns a 500 code for not been created' do
      product_on_stock = double(StockItem, id: 1, quantity: 1) 
      allow(product_on_stock).to receive(:persisted?)
        .and_return(false)

      expect(StockItem).to receive(:where)
        .with({ product_id: 1, store_id: 1 })
        .and_return([])

      expect(StockItem).to receive(:create)
        .with({ product_id: 1, store_id: 1, quantity: 1 })
        .and_return(product_on_stock)

      response_api = call_api
      expect(response_api.body).to eq("quantity not created")
      expect(response_api.status).to eq(500)
    end
  end

  describe 'POST /add_items?&store_id=1&quantity=1', type: :api do
    it 'returns a 400 to product_id missing' do
      response_api = call_api
      expect(response_api.body).to eq("product_id is missing")
      expect(response_api.status).to eq(400)
    end
  end
  
  describe 'POST /add_items?&product_id=1&quantity=1', type: :api do
    it 'returns a 400 to store_id missing' do
      response_api = call_api
      expect(response_api.body).to eq("store_id is missing")
      expect(response_api.status).to eq(400)
    end
  end

  describe 'POST /add_items?&store_id=1&product_id=1', type: :api do
    it 'returns a 400 to quantity missing' do
      response_api = call_api
      expect(response_api.body).to eq("quantity is missing")
      expect(response_api.status).to eq(400)
    end
  end

  describe 'POST /remove_items?product_id=1&store_id=1&quantity=1', type: :api do
    it 'returns a 201 code for been removed' do
      product_on_stock = double(StockItem, id: 1, quantity: 2, product_id: 1) 
      products_on_stock = [ product_on_stock ]

      expect(StockItem).to receive(:where)
        .with({ product_id: 1, store_id: 1 })
        .and_return(products_on_stock)

      expect(product_on_stock).to receive(:update)
        .with(quantity: 1)
        .and_return(true)

      response_api = call_api
      expect(response_api.body).to eq("new quantity of product 1 is 1")
      expect(response_api.status).to eq(201)
    end
  end

  describe 'POST /remove_items?product_id=1&store_id=1&quantity=50', type: :api do
    it 'returns a 500 for quantity overload' do
      product_on_stock = double(StockItem, id: 1, quantity: 2) 
      products_on_stock = [ product_on_stock ]

      expect(StockItem).to receive(:where)
        .with({ product_id: 1, store_id: 1 })
        .and_return(products_on_stock)

      response_api = call_api
      expect(response_api.body).to eq("quantity removed is not greater than the actual: 2")
      expect(response_api.status).to eq(500)
    end
  end

  describe 'POST /remove_items?product_id=1&store_id=1&quantity=1', type: :api do
    it 'returns a 500 when product is not updated' do
      product_on_stock = double(StockItem, id: 1, quantity: 2) 
      products_on_stock = [ product_on_stock ]

      expect(StockItem).to receive(:where)
        .with({ product_id: 1, store_id: 1 })
        .and_return(products_on_stock)

      expect(product_on_stock).to receive(:update)
        .with(quantity: 1)
        .and_return(false)

      response_api = call_api
      expect(response_api.body).to eq("product not updated")
      expect(response_api.status).to eq(500)
    end
  end

  describe 'POST /remove_items?product_id=1&store_id=1&quantity=1', type: :api do
    it 'returns a 500 when product is not updated' do
      expect(StockItem).to receive(:where)
        .with({ product_id: 1, store_id: 1 })
        .and_return([])

      response_api = call_api
      expect(response_api.body).to eq("product not found")
      expect(response_api.status).to eq(500)
    end
  end

  describe 'POST /remove_items?&store_id=1&quantity=1', type: :api do
    it 'returns a 400 to product_id missing' do
      response_api = call_api
      expect(response_api.body).to eq("product_id is missing")
      expect(response_api.status).to eq(400)
    end
  end
  
  describe 'POST /remove_items?&product_id=1&quantity=1', type: :api do
    it 'returns a 400 to store_id missing' do
      response_api = call_api
      expect(response_api.body).to eq("store_id is missing")
      expect(response_api.status).to eq(400)
    end
  end

  describe 'POST /remove_items?&store_id=1&product_id=1', type: :api do
    it 'returns a 400 to quantity missing' do
      response_api = call_api
      expect(response_api.body).to eq("quantity is missing")
      expect(response_api.status).to eq(400)
    end
  end
end