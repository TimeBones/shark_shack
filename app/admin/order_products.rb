ActiveAdmin.register OrderProduct do
  permit_params :product_id, :order_id, :quantity, :price
end
