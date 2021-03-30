ActiveAdmin.register Order do
 permit_params :date, :subtotal, :status, :user_id
end
