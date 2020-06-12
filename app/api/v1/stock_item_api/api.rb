module StockItemAPI
  class API < Grape::API

    params do
      requires :product_id, type: Integer 
      requires :store_id, type: Integer 
      requires :quantity, type: Integer 
    end

    post :add_items do
      product_on_stock = StockItem.where(
        product_id: params[:product_id],
        store_id: params[:store_id]).first
      
      if product_on_stock
        new_quantity = product_on_stock.quantity + params[:quantity]
        return "new quantity of product #{product_on_stock.product_id} is #{new_quantity}" if product_on_stock.update(quantity: new_quantity )
        response_message = "quantity not updated"
      else
        return "new product was added" if StockItem.create(declared(params)).persisted? 
        response_message = "quantity not created"
      end
      error!(response_message, 500)   
    end

    params do
      requires :product_id, type: Integer 
      requires :store_id, type: Integer 
      requires :quantity, type: Integer 
    end

    post :remove_items do
      product_on_stock = StockItem.where(
        product_id: params[:product_id],
        store_id: params[:store_id]).first

      if product_on_stock
        new_quantity = product_on_stock.quantity - params[:quantity]
        if new_quantity < 0
          return error!("quantity removed is not greater than the actual: #{product_on_stock.quantity}", 500)   
        else
          return "new quantity of product #{product_on_stock.product_id} is #{new_quantity}" if product_on_stock.update(quantity: new_quantity )
          return error!("product not updated", 500)   
        end
      end
      error!("product not found", 500)   
    end
  end
end
