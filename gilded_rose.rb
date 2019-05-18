require 'pry'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if !is_it_aged_brie?(item) and !is_it_backstage_passes?(item) 

        if item.quality > 0
          if  !is_it_sulfuras?(item)
						item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if is_it_backstage_passes?(item)
						if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if !is_it_sulfuras?(item) 
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if  !is_it_aged_brie?(item)
					if !is_it_backstage_passes?(item)
						if item.quality > 0
              if !is_it_sulfuras?(item) 
                item.quality = item.quality - 2
              end
            end
          else
            item.quality = 0 
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

	private
		def is_it_aged_brie?(item)
			item.name == 'Aged Brie'
		end

		def is_it_backstage_passes?(item)
			item.name == 'Backstage passes to a TAFKAL80ETC concert'
		end

		def is_it_sulfuras?(item)
			item.name == 'Sulfuras, Hand of Ragnaros'
		end
end

class Item
  #sell_in - number of days have to sell the item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
