require "test/unit"

require "wendenal"

class TestWendenal < Test::Unit::TestCase
  
  def setup
    @book = "1 book at 12.49"
    @chocolate = ["1", "chocolate bar", "0.85"]
    @chocolate = Item.new("1", "chocolate bar", "0.85")
    @choc_hash = Item.new("1", "chocolate bar", "0.85")
    @perf_hash = Item.new("1", "bottle of perfume","18.99")
    @pills_hash = Item.new("1", "packet of headache pills", "9.75")
    @imported_choc_hash = Item.new("1", "box of imported chocolates", "11.25")
    @imported_perf_hash = Item.new("1", "imported bottle of perfume", "27.99")
    @wend = Wendenal.new
  end
  
  def test_calculate_original_total
    @wend.items = [@choc_hash, @imported_choc_hash]
    assert_equal(12.10, @wend.calculate_original_total)
  end
  
  def test_calculate_tax
    @wend.items = [@perf_hash, @imported_perf_hash, @imported_choc_hash, @pills_hash]
    @wend.calculate_original_total
    assert_equal(6.70, @wend.calculate_tax.round(2))
  end

end