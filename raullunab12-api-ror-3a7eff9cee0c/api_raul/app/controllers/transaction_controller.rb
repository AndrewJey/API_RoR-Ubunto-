class TransactionController < ApplicationController

    def index
        @transactions = Transaction.all
        respond_to do |format|
            format.html { render json: @transactions }
            format.json { render json: @transactions }
        end
    end

    def new
        @transaction = Transaction.new
    end

    def create
        @msg
        @transaction = Transaction.new(transaction_params)
        @productoffert=Product.where(:id => @transaction.product_offered_id).first
        @productrequire=Product.where(:id => @transaction.product_req_id).first
        if(@productoffert== nil || @productrequire==nil)
            @msg={status:422 , message:'Producto offer id or require doesnt exits'}
        else
            if(@transaction.product_offered_id == @transaction.product_req_id)
                @msg={status:200 , message:'You can not repeat the identifier'}
            else
              if(Transaction.where(:product_offered_id => @transaction.product_offered_id).where(:product_req_id=>@transaction.product_req_id).first)
                @msg={status:422 , message:'There is already transaction with that arguments'}
              else
                if @transaction.save
                  @msg={status:200 , message:'Transaction created'}
                else
                  @msg={status:200 , message:'There was an a error created the transactions'}
                end
              end
            end
        end
      respond_to do |format|
        format.html { render json: @msg }
        format.json { render json: @msg }
      end
    end

private
    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
        params.permit(:product_offered_id, :product_req_id)
    end
end
