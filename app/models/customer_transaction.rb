class CustomerTransaction < ActiveRecord::Base
  belongs_to :customer

  def type
    if self.transaction_type == 0
      "Money Transfer"
    elsif self.transaction_type == 1
      "Bill Payment"
    end
  end

end
