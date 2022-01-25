class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
