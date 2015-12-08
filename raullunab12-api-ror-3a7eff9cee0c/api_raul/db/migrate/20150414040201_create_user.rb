class CreateUser < ActiveRecord::Migration
      def change
        create_table "users" do |t|
          t.string :user ,  :null => false , :unique => true
          t.string :password ,  :null => false
      end
      User.create :user=>'root' , :password=>'root'
    end
end