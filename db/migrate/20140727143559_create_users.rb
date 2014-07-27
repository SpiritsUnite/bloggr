class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, limit: 20
      t.string :password
      t.string :email

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
