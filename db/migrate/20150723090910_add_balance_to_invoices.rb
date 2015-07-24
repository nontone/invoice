class AddBalanceToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :balance, :float, default: 0
  end
end
