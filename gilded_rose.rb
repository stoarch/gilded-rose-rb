require 'pry'

class GildedRose
	MAX_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
			next if is_it_sulfuras?(item)

			update_item_quality(item)
			update_item_sell_in(item)
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

		def update_item_quality(item)
      if is_it_obsolescent_item?(item)
				decrease_quality(item)
      else
				increase_quality(item)

				if is_it_backstage_passes?(item)
					update_backstage_passes_quality(item)
				end
      end
		end

		def is_it_obsolescent_item?(item)
			!is_it_aged_brie?(item) and !is_it_backstage_passes?(item) 
		end

		def increase_quality(item)
			if item.quality < MAX_QUALITY 
				item.quality = item.quality + 1
			end
		end

		def decrease_quality(item)
			if item.quality > 0
					item.quality = item.quality - 1
			end
		end

		def update_backstage_passes_quality(item)
			if item.sell_in < 11 #days
				increase_quality(item)
			end
			if item.sell_in < 6 #days 
				increase_quality(item)
			end
		end

		def update_item_sell_in(item)
			#sell_in - number of days have to sell the item
			item.sell_in = item.sell_in - 1
      if item.sell_in < 0
        if  !is_it_aged_brie?(item)
					if !is_it_backstage_passes?(item)
						if item.quality > 0
                item.quality = item.quality - 1
            end
          else
            item.quality = 0 
          end
        else
          if item.quality < MAX_QUALITY 
            item.quality = item.quality + 1
          end
        end
      end
		end
end

class Item
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
