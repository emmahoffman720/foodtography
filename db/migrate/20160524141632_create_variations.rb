class CreateVariations < ActiveRecord::Migration
  def change
    create_table :variations do |t|

      t.string :title
      t.text :description
      t.text :recipe

      t.integer :user_id
      t.integer :post_id

      t.timestamps

    end

    add_index :variations, :user_id
    add_index :variations, :post_id
    
  end
end
