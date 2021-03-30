ActiveAdmin.register User do
  permit_params :username, :password, :powerlevel, :email, :address, :active
end
