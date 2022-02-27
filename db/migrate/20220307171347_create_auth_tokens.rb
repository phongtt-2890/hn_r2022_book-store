class CreateAuthTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :auth_tokens do |t|
      t.string :token
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
