class Invoice < ActiveRecord::Base
  has_many :lineitems
  has_many :extras

  validates :name, presence: true
  validates :number, presence: true, uniqueness: true

  after_initialize :generate_number, if: :new_record?
  after_save -> { extras.each(&:save) }, if: :sub_total_changed?
  before_save :calculate_balance

  accepts_nested_attributes_for :lineitems, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :extras, reject_if: :all_blank, allow_destroy: true

  scope :latest, -> { order("number desc") }

  def generate_number
    self.number = (Invoice.maximum(:number) || '0000').succ
    self.issue_date = Date.today
  end

  def calculate_sub_total
    self.sub_total = lineitems.sum(:amount)
    self.save
  end

  def calculate_balance
    self.total = sub_total + extras.extra_cost.sum(:amount) - extras.discount.sum(:amount)
    self.balance = total + (total * 0.07)
  end
end
