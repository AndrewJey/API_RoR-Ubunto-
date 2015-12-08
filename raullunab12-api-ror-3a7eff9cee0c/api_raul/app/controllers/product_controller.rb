class ProductController < ApplicationController
 before_action :set_product, only: [:show, :update]

  def index_page
      respond_to do |format|
        format.html { render template: "/layouts/application" }
      end
  end
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    msg = { status: 200 ,  product: @products }
      respond_to do |format|
        format.html { render json: msg }
        format.json { render json: msg }
      end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @products = Product.find_by_id(params[:id])
    msg = { status: 200 ,  product: @products }
      respond_to do |format|
        format.html { render json: msg }
        format.json { render json: msg }
      end
  end

  # GET /products/new
  def new
    @products = Product.new
  end

  # POST /products
  # POST /products.json
  def create
    newProduct = Product.new(products_params)
    if newProduct.save
      msg = { status: 201 ,  product: newProduct }
      respond_to do |format|
        format.html { render json: msg }
        format.json { render json: msg }
      end
    else
      msg = { status: 422 }
      respond_to do |format|
        format.html { render json: msg }
        format.json { render json: msg }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    updateProduct = Product.find_by_id(params[:id])
    updateProduct.update(products_params)
    if updateProduct != nil
      msg = { status: 200 ,  product: updateProduct }
      respond_to do |format|
        format.html { render json: msg }
        format.json { render json: msg }
      end
    else
      msg = { status: 422 }
      respond_to do |format|
        format.html { render json: msg }
        format.json { render json: msg }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @products = Product.find_by_id(params[:id])
      if @products != nil
        return true
      else
        msg = { status: 404 , response: {error:'Value does not exist.'}}
        respond_to do |format|
          format.html { render json: msg }
          format.json { render json: msg }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def products_params
      params.permit(:name, :description, :estado)
    end
end