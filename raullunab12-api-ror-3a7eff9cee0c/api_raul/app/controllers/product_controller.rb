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
    msg = { status: 200, product: @products }
    respond_to do |format|
      format.html { render json: msg, status: :ok }
      format.json { render json: msg, status: :ok }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    msg = { status: 200, product: @products }
    respond_to do |format|
      format.html { render json: msg, status: :ok }
      format.json { render json: msg, status: :ok }
    end
  end

  # GET /products/new
  def new
    @products = Product.new
  end

  # POST /products
  # POST /products.json
  def create
    new_product = Product.new(products_params)
    if new_product.save
      msg = { status: 201, product: new_product }
      http_status = :created
    else
      msg = { status: 422, errors: new_product.errors.full_messages }
      http_status = :unprocessable_entity
    end
    respond_to do |format|
      format.html { render json: msg, status: http_status }
      format.json { render json: msg, status: http_status }
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if @products.nil?
      msg = { status: 404, response: { error: 'Value does not exist.' } }
      http_status = :not_found
    elsif @products.update(products_params)
      msg = { status: 200, product: @products }
      http_status = :ok
    else
      msg = { status: 422, errors: @products.errors.full_messages }
      http_status = :unprocessable_entity
    end
    respond_to do |format|
      format.html { render json: msg, status: http_status }
      format.json { render json: msg, status: http_status }
    end
  end

  private

  def set_product
    @products = Product.find_by(id: params[:id])
    return if @products

    msg = { status: 404, response: { error: 'Value does not exist.' } }
    respond_to do |format|
      format.html { render json: msg, status: :not_found }
      format.json { render json: msg, status: :not_found }
    end
  end

  def products_params
    params.permit(:name, :description, :estado)
  end
end
