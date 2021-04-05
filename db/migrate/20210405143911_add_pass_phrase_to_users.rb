class AddPassPhraseToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :passphrase, :string
  end
end
