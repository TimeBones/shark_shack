class AddMoreTaxesToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :tax_rate, :float
  end
end
