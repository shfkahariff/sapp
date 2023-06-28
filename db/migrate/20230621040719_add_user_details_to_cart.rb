class AddUserDetailsToCart < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :name, :string
    add_column :carts, :email, :string
    add_column :carts, :phone, :string
  end
end
