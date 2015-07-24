class CreateExtras < ActiveRecord::Migration
  def change
    create_table :extras do |t|
      t.integer :kind
      t.string :name
      t.integer :method
      t.decimal :value, precision: 5, scale: 2, default: 0
      t.float :amount
      t.references :invoice

      t.timestamps null: false
    end

    add_column :invoices, :total, :float, default: 0
  end
end
