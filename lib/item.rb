class Item
  
  UNTAXED = ["book", "chocolate", "headache pills"]
  UNTAXED_REGEX = Regexp.new(UNTAXED.join("|"))
  
  attr_accessor :quantity, :name, :cost
  
  def initialize(quantity, name, cost)
    @name = name
    @quantity = quantity.to_i
    @cost = cost.to_f
  end
  
  def volume_cost
    @cost * @quantity
  end
  
  def tax_rate
    if name.match(UNTAXED_REGEX) && name.include?("import")
        rate = 5
    elsif name.match(UNTAXED_REGEX)
        rate = 0
    elsif name.include? "import"
        rate = 15
    else
        rate = 10
    end
  end
  
end