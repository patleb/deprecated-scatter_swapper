class ProductsController < ApplicationController
  def show
    @id = params.require(:id)
  end
end
