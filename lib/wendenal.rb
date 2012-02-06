#!/usr/bin/ruby


class Wendenal

  untaxed = ["book", "chocolate", "headache pills"]
  UNTAXED_REGEX = Regexp.new(untaxed.join("|"))

  def parse_items
    @items = []

    File.open("#{ARGV}").each_line do |line|
      @items << line.scan(/(\d+) (.*) at (\d{1,2}.\d{2})/).flatten
    end
  end

  def calculate_tax
    tax = []
    @items.each do |item|
      if item[1].match(UNTAXED_REGEX)
        if item[1].include? "import"
          item[2] = taxed_cost(item[2], 5)
        end
      else
        if item[1].include? "import"
          item[2] = taxed_cost(item[2], 15)
        else
          item[2] = taxed_cost(item[2], 10)
        end
      end
      tax << item[2]
    end

    tax = tax.inject(:+)
    @taxed_total = tax
  end

  def taxed_cost(original_price, tax_percentage)
    unrounded_tax = (original_price * tax_percentage) / 100
    rounded_tax = (unrounded_tax * 20).ceil / 20.0
    total_item_cost = original_price + rounded_tax
  end

  def calculate_total

    total = []

    @items.each do |item|
      item[2] = item[2].to_f
      total << item[2]
    end

    @total =  total.inject(:+)

  end

  def print_receipt
    @items.each do |item|
      puts "#{item[0]} #{item[1]}: #{"%.2f" % item[2]}"
    end

    puts "Sales Tax: #{"%.2f" % (@taxed_total - @total)}"
    puts "Total: #{"%.2f" % @taxed_total}"
  end



end

transaction = Wendenal.new
transaction.parse_items
transaction.calculate_total
transaction.calculate_tax
transaction.print_receipt
