class AddIndexToUsersEmail < ActiveRecord::Migration
  def up
  	execute %{CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email" COLLATE NOCASE)}    
  end

  def down
    execute %{DROP INDEX "index_users_on_email"}
  end
end
