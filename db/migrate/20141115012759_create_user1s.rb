class CreateUser1s < ActiveRecord::Migration
  def change
    create_table :user1s do |t|
      t.string :login
      t.string :hashed_password
      t.string :salt

      t.timestamps
    end
  end
end
