class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :number
      t.string :name
      t.date :issue_date

      t.timestamps null: false
    end
  end
end
