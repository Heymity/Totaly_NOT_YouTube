class AddAuthTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :auth_token, :string
    remove_index :users, :auth_token
    add_index :users, :auth_token, unique: true
  end
end
