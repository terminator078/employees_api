class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :team_number
      t.string :role
      t.string :mobile
      t.string :auth_token

      t.timestamps
    end
  end
end
