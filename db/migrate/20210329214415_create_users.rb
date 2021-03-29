class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.int :powerlevel
      t.string :email
      t.string :address
      t.int :active

      t.timestamps
    end
  end
end
