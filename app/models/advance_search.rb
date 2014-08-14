class AdvanceSearch < ActiveRecord::Base
  
  def transactions
    @transactions||=find_transactions
  end
  private
  
  def find_transactions
    Spending.where(conditions)
  end
  def keyword_conditions
  ["spendings.title LIKE ?", "%#{keyword}%"] unless keyword.blank?
  end
  def minimum_price_conditions
    ["spendings.price >= ?", minimum_price] unless minimum_price.blank?
  end
  def maximum_price_conditions
  ["spendings.price <= ?", maximum_price] unless maximum_price.blank?
  end
  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end
end
