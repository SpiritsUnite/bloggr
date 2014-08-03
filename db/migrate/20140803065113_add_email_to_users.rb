class AddEmailToUsers < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute %{ALTER TABLE "users" ADD COLUMN email varchar(255) COLLATE NOCASE}
      end
      dir.down do
        remove_column :users, :email, :string
      end
    end

    add_index :users, :email, unique: true

  end
end
