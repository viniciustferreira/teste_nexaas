# README

Instruções para o uso dos endpoints: 

São 3 tipos de dados:
  * Products -produtos.
  * Stores -lojas.
  * StockItems -Os itens de estoque para cada loja.
  
Tanto products '/v1/product_api/' como stores '/v1/store_api/' tem os mesmos métodos:
  '/create' - cria um novo registro - parametros: 'name' - nome (obrigatório),
    'address' - endereço (obrigatório) (apenas no stores),
    'cost' - preço de custo (obrigatório) (apenas no products),
    'description' - descrição (obrigatório) (apenas no products)
    
  '/update' - autaliza o registro - parametros: 'id' - o id do resgitro (obrigatório),
    'name' - nome a ser alterado(opcional),
    'address' - endereço a ser alterado (opcional) (apenas no stores),
    'cost' - preço de custo a ser alterado(opcional) (apenas no products),
    'description' - descrição a ser alterada(opcional) (apenas no products)
    
  '/search' - busca de um registro - parametro: 'id' - o id do registro a ser buscado (obrigatório)
  '/delete' - delete um registro - parametro: 'id' - o id do registro a ser deletado (obrigatório)
  
  No caso do StockItems '/v1/stock_item_api/ existem 2 métodos:
  
  '/add_items' - Ele atualiza o valor de um produto de uma loja ou, se não existir, cria um novo item com a quantidade passada. parâmetros: product_id - id do produto, store_id - id da loja, quantity: quantidade a ser somada ao valor do estoque ou a ser iniciada se não existir.  
  
  'remove_items' - Remove um valor da quantidade dos produtos de uma loja. parâmetros: product_id - id do produto, store_id - id da loja, quantity: quantidade a ser diminuída do valor do estoque (não pode ser maior que o valor do estoque).
 
 PS: Para rodar ele em ambiente local, basta baixar as dependências com bundle install, depois criar a base de dados com rails db:create/rails db:migrate e rails s para subir o servidor.
 
 Tentei criar o app no Heroku, como foi pedido, mas houve um problema ao baixar as dependências e não consgui resolver a tempo. 
 
 
