class CreateProduct < ActiveRecord::Migration
  def change
	create_table "products" do |t|
			t.string :name,  :null => false
			t.string :description,	:null => false
			t.string :estado, :null => false
	end
  end
end
