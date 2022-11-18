class Payment < ApplicationRecord
  belongs_to :ticket
  belongs_to :user

  def ticket
    Ticket.unscoped { super }
  end
end
