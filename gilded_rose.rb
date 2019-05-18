require 'pry'

class ItemProcessor
	MAX_QUALITY = 50

	attr :item

	def initialize(item)
		@item = item
	end

	def update
		update_quality
		update_sell_in
	end

	protected
		def update_quality
			#do nothing - redefined in child classes
		end

		def update_sell_in
			decrease_sell_in

			if item.sell_in < 0
				decrease_quality
			end
		end

		def decrease_sell_in
			item.sell_in = item.sell_in - 1
		end

		def increase_quality()
			if item.quality < MAX_QUALITY 
				item.quality = item.quality + 1
			end
		end

		def decrease_quality()
			if item.quality > 0
					item.quality = item.quality - 1
			end
		end
end

class ObsolescentItemProcessor < ItemProcessor 
	def update_quality
		super
		decrease_quality
	end
end

class LegendaryItemProcessor < ItemProcessor
	def update_sell_in
		#do nothing - it can not be sold
	end

	def update_quality
		#do nothing - it not aged nor discounted
	end
end

class AgedItemProcessor < ItemProcessor
	def update_sell_in
		super
		increase_quality if item.sell_in < 0 # aged twice update quality
	end

	def update_quality
		super
		increase_quality
	end
end

class BackstagePassItemProcessor < AgedItemProcessor
	def update_sell_in
		super

		item.quality = 0 if item.sell_in <= 0 # backstage passes cost nothing after stage
	end

	def update_quality
		super

		increase_quality if item.sell_in < 11 #days
		increase_quality if item.sell_in < 6 #days 
	end
end

class ConjuredItemProcessor < ObsolescentItemProcessor
	def update_quality
		super
		decrease_quality # twice as base item
	end
end

# Manager for gilded rose inn items
class GildedRose
	MAX_QUALITY = 50

  def initialize(items)
    @items = items
		init_processors
  end

  def update_quality()
    @items.each do |item|
			processor = item_processors[item]
			processor.update unless processor.nil?
    end
  end

	private
		attr :item_processors
		attr :items

		def init_processors
			@item_processors = {}

			items.each do |item|
				processor = nil

				processor = get_aged_processor(item) if is_it_aged_brie?(item)
				processor = get_backstage_passes_processor(item) if is_it_backstage_passes?(item)
				processor = get_conjured_processor(item) if is_it_conjured?(item)
				processor = get_legendary_processor(item) if is_it_sulfuras?(item)

				processor = get_default_processor(item) if processor.nil?

				@item_processors[item] = processor
			end
		end

		def get_default_processor(item)
			ObsolescentItemProcessor.new(item)
		end

		def get_aged_processor(item)
			AgedItemProcessor.new(item)
		end

		def get_backstage_passes_processor(item)
			BackstagePassItemProcessor.new(item)
		end

		def get_legendary_processor(item)
			LegendaryItemProcessor.new(item)
		end

		def get_conjured_processor(item)
			ConjuredItemProcessor.new(item)
		end

		def is_it_aged_brie?(item)
			item.name == 'Aged Brie'
		end

		def is_it_backstage_passes?(item)
			item.name == 'Backstage passes to a TAFKAL80ETC concert'
		end

		def is_it_sulfuras?(item)
			item.name == 'Sulfuras, Hand of Ragnaros'
		end

		def is_it_conjured?(item) 
			item.name == 'Conjured'
		end

		def is_it_obsolescent_item?(item)
			!is_it_aged_brie?(item) and !is_it_backstage_passes?(item) 
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
