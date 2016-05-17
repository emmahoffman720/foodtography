class CreateRelatedRecipes < ActiveRecord::Migration
  def change
    create_table :related_recipes do |t|

      t.string :title
      t.integer :user_id
      t.text :message
      t.text :recipe
      t.integer :post_id

      t.timestamps

      # add_index :related_recipes, :user_id
      # add_index :related_recipes, :post_id
    end
  end
end
