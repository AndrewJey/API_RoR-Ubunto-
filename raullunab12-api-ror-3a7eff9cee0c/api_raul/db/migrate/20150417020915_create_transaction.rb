class CreateTransaction < ActiveRecord::Migration
  def change
	create_table "transactions" do |t|
			t.integer :product_req_id, :null => false
			t.integer :product_offered_id, :null => false
	end
  end
end
