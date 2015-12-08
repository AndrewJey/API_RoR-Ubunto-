class CreateApiKeys < ActiveRecord::Migration
	def change
		create_table :api_keys do |t|
			t.string :access_token,  :null => false
			t.string :userId,	:null => false
			t.datetime :current, :null => false
		end
	end
end