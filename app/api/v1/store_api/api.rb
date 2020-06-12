module StoreAPI
  class API < Grape::API

    params do 
      requires :name, type: String
      requires :address, type: String
    end

    post :create do
      store = Store.create(declared(params))
      if store.persisted?
        return "ok"
      end
      error!( "store not created" , 500)
    end

    params do 
      requires :id, type: Integer
      optional :name, type: String
      optional :address, type: String
    end

    post :update do
      updated_params = {
        name: params[:name], 
        address: params[:address] 
      }

      store = Store.where(id: params[:id]).first
      if store&.update(updated_params)
        return "ok" 
      end
      error!( "store not updated" , 500)
    end

    params do 
      requires :id, type: Integer
    end

    get :search do
      store = Store.where(id: params[:id]).first
      if store
        return { id: store.id,
          name: store.name, 
          address: store.address
      }.to_json
      end
      error!( "store not found" , 500)
    end

    params do 
      requires :id, type: Integer
    end

    post :delete do
      begin
        Store.destroy(params[:id])
        return "store #{params[:id]} deleted"
      rescue
        error!( "store not found" , 500)
      end
    end
  end
end