ActiveAdmin.register User do
  permit_params :username, :passphrase, :powerlevel, :email, :address, :active
end
