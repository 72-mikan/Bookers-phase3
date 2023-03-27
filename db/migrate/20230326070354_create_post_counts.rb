class CreatePostCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :post_counts do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
