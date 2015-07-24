class CreateLineitems < ActiveRecord::Migration
  def change
    create_table :lineitems do |t|
      t.string :name
      t.integer :quantity
      t.float :amount
      t.float :price
      t.references :invoice

      t.timestamps null: false
    end

    add_column :invoices, :sub_total, :float, scale: 2, default: 0
  end
end
