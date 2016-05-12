class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :message
      t.text :recipe


      t.timestamps
    end
  end
end
