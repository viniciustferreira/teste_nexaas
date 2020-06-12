require 'rails_helper'

RSpec.describe StoreAPI::API do 
  describe 'POST /create?name=loja&address=hahaha', type: :api do
    it 'returns a id from a new store' do
      store = double(Store)
      expect(Store).to receive(:create)
        .with({ name: "loja", address: "hahaha" })
        .and_return(store)

      expect(store).to receive(:persisted?).and_return(true)

      expect(call_api.status).to eq(201)
    end
  end

  describe 'POST /create?name=loja&address=hahaha', type: :api do
    it 'returns error 500' do
      store = double(Store, persisted?: false)
      allow(store).to receive(:persisted?) { false }
      allow(Store).to receive(:create)
        .with({ name: "loja", address: "hahaha" })
        .and_return(store)

      response_api = call_api
      expect(response_api.body).to eq("store not created")
      expect(response_api.status).to eq(500)
    end
  end

  describe 'POST /create?&address=hahaha', type: :api do
    it 'returns no name error' do
      response_api = call_api
      expect(response_api.body).to eq("name is missing")
      expect(response_api.status).to eq(400)
    end
  end

  describe 'POST /create?name=teste', type: :api do
    it 'returns no address error' do
      response_api = call_api
      expect(response_api.body).to eq("address is missing")
      expect(response_api.status).to eq(400)
    end
  end

  describe "POST /update?&id=1&name=store2", type: :api do
    it 'returns status 201' do
      store = double(Store, id: 1, name: "store")
      allow(store).to receive(:update).and_return(true)
      stores = [ store ]
      expect(Store).to receive(:where)
        .with(id: 1)
        .and_return(stores)

      response_api = call_api
      expect(response_api.body).to eq("ok")
      expect(response_api.status).to eq(201)
    end
  end

  describe "POST /update?&id=0&name=store2", type: :api do
    it 'returns status 500' do
      expect(call_api.body).to eq("store not updated")
      expect(call_api.status).to eq(500)
    end
  end
  
  describe "POST /update?&name=store2", type: :api do
    it 'returns status 400 and message of missing id' do
      expect(call_api.body).to eq("id is missing")
      expect(call_api.status).to eq(400)
    end
  end

  describe "GET /search?&id=1", type: :api do
    it 'returns status 200' do
      stores = [ double(Store, id: 1, name: "bla", address: "bla" )]
      expect(Store).to receive(:where)
        .and_return(stores)

      response_api = call_api
      expect(JSON.parse(response_api.body)).to eq({ "id" => 1, "name" => "bla", "address" => "bla" })
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
      expect(call_api.body).to eq("store not found")
      expect(call_api.status).to eq(500)
    end
  end

  describe "POST /delete?&id=1", type: :api do
    it 'returns status 201' do
      number = 1
      expect(Store).to receive(:destroy)
        .with(1)

      response_api = call_api
      expect(response_api.body).to eq("store 1 deleted")
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
      expect(call_api.body).to eq("store not found")
      expect(call_api.status).to eq(500)
    end
  end
end