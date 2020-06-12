module ProductAPI
  class API < Grape::API

    params do 
      requires :name, type: String
      requires :description, type: String
      requires :cost, type: Integer
    end

    post :create do
      product = Product.create(declared(params))
      if product.persisted?
        return "ok"
      end
      error!( "product not created" , 500)
    end

    params do 
      requires :id, type: Integer
      optional :name, type: String
      optional :description, type: String
      optional :cost, type: Integer
    end

    post :update do
      updated_params = {
        name: params[:name], 
        cost: params[:cost], 
        description: params[:description]
      }

      product = Product.where(id: params[:id]).first
      if product&.update(updated_params)
        return "ok" 
      end
      error!( "product not updated" , 500)
    end

    params do 
      requires :id, type: Integer
    end

    get :search do
      product = Product.where(id: params[:id]).first
      if product
        return { id: product.id,
          name: product.name, 
          cost: product.cost,
          description: product.description,
      }.to_json
      end
      error!( "product not found" , 500)
    end

    params do 
      requires :id, type: Integer
    end

    post :delete do
      begin
        Product.destroy(params[:id])
        "product #{params[:id]} deleted"
      rescue
        error!( "product not found" , 500)
      end
    end
  end
end