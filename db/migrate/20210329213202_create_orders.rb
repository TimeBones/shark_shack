class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.date :date
      t.int :subtotal
      t.int :status
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
