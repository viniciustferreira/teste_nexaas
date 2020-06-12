require 'rails_helper'

RSpec.describe ProductAPI::API do 
  describe 'POST /create?name=produto&cost=1&description=hahaha', type: :api do
    it 'returns a id from a new product' do
      product = double(Product)
      expect(Product).to receive(:create)
        .with({ name: "produto", description: "hahaha", cost: 1 })
        .and_return(product)

      expect(product).to receive(:persisted?).and_return(true)

      expect(call_api.status).to eq(201)
    end
  end

  describe 'POST /create?name=produto&cost=1&description=hahaha', type: :api do
    it 'returns error 500' do
      product = double(Product, persisted?: false)
      allow(product).to receive(:persisted?) { false }
      allow(Product).to receive(:create)
        .with({ name: "produto", description: "hahaha", cost: 1 })
        .and_return(product)

      response_api = call_api
      expect(response_api.body).to eq("product not created")
      expect(response_api.status).to eq(500)
    end
  end

  describe 'POST /create?&cost=1&description=hahaha', type: :api do
    it 'returns no name error' do
      response_api = call_api
      expect(response_api.body).to eq("name is missing")
      expect(response_api.status).to eq(400)
    end
  end

  describe 'POST /create?name=teste&cost=1', type: :api do
    it 'returns no description error' do
      response_api = call_api
      expect(response_api.body).to eq("description is missing")
      expect(response_api.status).to eq(400)
    end
  end

  describe 'POST /create?name=teste&description=hahaha', type: :api do
    it 'returns no cost error' do
      response_api = call_api
      expect(response_api.body).to eq("cost is missing")
      expect(response_api.status).to eq(400)
    end
  end

  describe "POST /update?&id=1&name=product2", type: :api do
    it 'returns status 201' do
      product = double(Product, id: 1, name: "product")
      allow(product).to receive(:update).and_return(true)
      products = [ product ]
      expect(Product).to receive(:where)
        .with(id: 1)
        .and_return(products)

      response_api = call_api
      expect(response_api.body).to eq("ok")
      expect(response_api.status).to eq(201)
    end
  end

  describe "POST /update?&id=0&name=product2", type: :api do
    it 'returns status 500' do
      expect(call_api.body).to eq("product not updated")
      expect(call_api.status).to eq(500)
    end
  end
  
  describe "POST /update?&name=product2", type: :api do
    it 'returns status 400 and message of missing id' do
      expect(call_api.body).to eq("id is missing")
      expect(call_api.status).to eq(400)
    end
  end

  describe "GET /search?&id=1", type: :api do
    it 'returns status 200' do
      products = [ double(Product, id: 1, name: "bla", cost: 1, description: "bla" )]
      expect(Product).to receive(:where)
        .and_return(products)

      response_api = call_api
      expect(JSON.parse(response_api.body)).to eq({ "id" => 1, "name" => "bla", "cost" => 1, "description" => "bla" })
      expect(response_api.status).to eq(200)
    end
  end

  describe "GET /search", type: :api do
    it 'returns status 400 and message of missing id' do
      expect(call_api.body).to eq("id is missing")
      expect(call_api.status).to eq(400)
    end
  end

  describe "GET /search?&id=0", type: :api do
    it 'returns status 500' do
      expect(call_api.body).to eq("product not found")
      expect(call_api.status).to eq(500)
    end
  end

  describe "POST /delete?&id=1", type: :api do
    it 'returns status 201' do
      number = 1
      expect(Product).to receive(:destroy)
        .with(1)

      response_api = call_api
      expect(response_api.body).to eq("product 1 deleted")
      expect(response_api.status).to eq(201)
    end
  end

  describe "POST /delete", type: :api do
    it 'returns status 400 and message of missing id' do
      expect(call_api.body).to eq("id is missing")
      expect(call_api.status).to eq(400)
    end
  end

  describe "POST /delete?&id=0", type: :api do
    it 'returns status 500' do
      expect(call_api.body).to eq("product not found")
      expect(call_api.status).to eq(500)
    end
  end
end