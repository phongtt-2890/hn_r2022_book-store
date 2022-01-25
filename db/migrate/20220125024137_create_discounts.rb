class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.string :name
      t.integer :discount_percent
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
