class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all.latest
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new
    @invoice = Invoice.new
    @invoice.lineitems.build
    @invoice.extras.build
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to invoice_path(@invoice), flash: { success: 'create invoice success!' }
    else
      redirect_to :back, flash: { error: @invoice.errors.full_messages }
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update_attributes(invoice_params)
      redirect_to invoice_path(@invoice), flash: { success: 'update invoice success!' }
    else
      redirect_to :back, flash: { error: @invoice.errors.full_messages }
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(
      :number, :name, :issue_date,
      lineitems_attributes: [
        :id, :name, :quantity, :price, :amount, :_destroy
      ],
      extras_attributes: [
        :id, :kind, :name, :method, :value, :_destroy
      ]
    )
  end
end