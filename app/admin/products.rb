ActiveAdmin.register Product do
  permit_params :name, :desc, :price, :weight, :status, :category_id
end
