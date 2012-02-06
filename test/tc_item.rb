require "test/unit"

require "item"

class TestItem < Test::Unit::TestCase
  
  def setup
    @chocolate = Item.new("1", "chocolate bar", "0.85")
    @choc_hash = Item.new("1", "chocolate bar", "0.85")
    @perf_hash = Item.new("1", "bottle of perfume","18.99")
    @pills_hash = Item.new("1", "packet of headache pills", "9.75")
    @imported_choc_hash = Item.new("1", "box of imported chocolates", "11.25")
    @imported_perf_hash = Item.new("1", "imported bottle of perfume", "27.99")
    
  end
  
  def test_tax_rate
    assert_equal(0, @choc_hash.tax_rate)
    assert_equal(5, @imported_choc_hash.tax_rate)
    assert_equal(10, @perf_hash.tax_rate)
    assert_equal(15, @imported_perf_hash.tax_rate)
  end
 
  
end