class Transaction
  # Methods
  def self.amount_for_type(type)
    case type
    when 'gold' then 6000
    when 'diamond' then 5500
    when 'platinum' then 5000
    end
  end
end
