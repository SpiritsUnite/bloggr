require_relative '20140730111331_add_index_to_users_email'

class RemoveEmailFromUsers < ActiveRecord::Migration
  def change
    revert AddIndexToUsersEmail
    remove_column :users, :email, :string
  end
end
