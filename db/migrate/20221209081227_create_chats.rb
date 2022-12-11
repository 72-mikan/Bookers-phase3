class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      
      t.integer :user_id
      t.integer :followed_id
      t.text :body

      t.timestamps
    end
  end
end
