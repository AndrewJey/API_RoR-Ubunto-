class TransactionController < ApplicationController
  def index
    @transactions = Transaction.all
    respond_to do |format|
      format.html { render json: @transactions, status: :ok }
      format.json { render json: @transactions, status: :ok }
    end
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    product_offered = Product.find_by(id: @transaction.product_offered_id)
    product_required = Product.find_by(id: @transaction.product_req_id)

    if product_offered.nil? || product_required.nil?
      @msg = { status: 422, message: 'Offered or requested product does not exist.' }
      http_status = :unprocessable_entity
    elsif @transaction.product_offered_id == @transaction.product_req_id
      @msg = { status: 422, message: 'You cannot repeat the product identifier.' }
      http_status = :unprocessable_entity
    elsif Transaction.exists?(product_offered_id: @transaction.product_offered_id, product_req_id: @transaction.product_req_id)
      @msg = { status: 422, message: 'There is already a transaction with those products.' }
      http_status = :unprocessable_entity
    elsif @transaction.save
      @msg = { status: 201, message: 'Transaction created', transaction: @transaction }
      http_status = :created
    else
      @msg = { status: 422, message: 'Could not create the transaction.', errors: @transaction.errors.full_messages }
      http_status = :unprocessable_entity
    end

    respond_to do |format|
      format.html { render json: @msg, status: http_status }
      format.json { render json: @msg, status: http_status }
    end
  end

  private

  def transaction_params
    params.permit(:product_offered_id, :product_req_id)
  end
end
