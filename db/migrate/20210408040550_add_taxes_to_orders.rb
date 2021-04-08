class AddTaxesToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :tax, :int
    add_column :orders, :tax_label, :string
  end
end
