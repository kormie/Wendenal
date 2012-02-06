require "./item"
class Wendenal
  LINE_PARSER = /(\d+) (.*) at (\d{1,2}.\d{2})/
  attr_accessor :items

  def parse_file(file)
    @items = []
    File.open("#{file}").each_line do |line|
      match_array = line.scan(LINE_PARSER).flatten
      @items << Item.new(match_array[0], match_array[1], match_array[2])
    end
  end

  def calculate_original_total
    total = []
    @items.each do |item|
      total << item.volume_cost
    end
    @original_total = total.inject(:+)
  end

  def calculate_tax
    tax = []
    @items.each do |item|
      item.cost = taxed_cost(item.cost, item.tax_rate )
      tax << item.volume_cost
    end

    @taxed_total = tax.inject(:+)
    @total_tax = @taxed_total - @original_total
  end

  def print_receipt
    @items.each do |item|
      puts "#{item.quantity} #{item.name}: #{formated_price(item.volume_cost)}\n"
    end

    puts "Sales Taxes: #{formated_price(@total_tax)}\n"
    puts "Total: #{formated_price(@taxed_total)}\n"
  end
  
private

  def taxed_cost(original_price, tax_percentage)
    unrounded_tax = (original_price * tax_percentage) / 5
    rounded_tax = unrounded_tax.ceil / 20.0
    total_item_cost = original_price + rounded_tax
  end

  def formated_price(unformated_price)
    "%.2f" % unformated_price
  end

end

ARGV.each do |file|
  w = Wendenal.new
  puts "\n===#{file}===\n\n"
  w.parse_file(file)
  w.calculate_original_total
  w.calculate_tax
  w.print_receipt
end


