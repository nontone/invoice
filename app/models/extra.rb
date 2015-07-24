class Extra < ActiveRecord::Base
  enum kind: %w(Discount Extra\ cost)
  enum method: %w(Value Percentage)

  belongs_to :invoice

  before_save :calculate_amount
  after_save { invoice.save }

  scope :discount, -> { where(kind: Extra.kinds['Discount']) }
  scope :extra_cost, -> { where(kind: Extra.kinds['Extra cost']) }

  def calculate_amount
    self.amount =
      case method
      when 'Value' then value
      when 'Percentage' then (invoice.sub_total * value) / 100
      end
  end
end