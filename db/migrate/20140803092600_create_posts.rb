class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, limit: 50
      t.text :body
      t.boolean :published
      t.references :author, index: true

      t.timestamps
    end
  end
end
