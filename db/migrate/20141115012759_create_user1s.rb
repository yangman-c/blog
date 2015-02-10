class CreateUser1s < ActiveRecord::Migration
  def change
    create_table :user1s do |t|
      t.string :login
      t.string :hashed_password
      t.string :salt

      t.timestamps
    end
	  create_table "users", :force => true do |t|
	    t.string   "nickname"
	    t.string   "email"
			t.timestamps
	  end
  end


end
