class AddSellerToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :seller, foreign_key: {to_table: :customers}
  end
end
