class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.timestamps null: false
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.string :password
      t.integer :gender
      t.string :phone
      t.string :country
      t.date :birthdate
      t.references :role
      t.string :encrypted_password, limit: 128, null: false
      t.string :confirmation_token, limit: 128
      t.string :remember_token, limit: 128, null: false
      t.timestamps
    end

    add_index :users, :email
    add_index :users, :remember_token
  end
end
