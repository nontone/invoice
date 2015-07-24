class Lineitem < ActiveRecord::Base
  belongs_to :invoice

  before_save :calculate_amount
  after_save { invoice.calculate_sub_total }

  def calculate_amount
    self.amount = quantity * price
  end
end
