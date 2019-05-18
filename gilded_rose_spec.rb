require File.join(File.dirname(__FILE__), 'gilded_rose')
AGED_BRIE = 1
SULFURAS = 2
BACKSTAGE_PASSES = 3

describe GildedRose do

	let(:items) { [
		Item.new('foo', 10, 11),
		Item.new('Aged Brie', 11, 10),
		Item.new('Sulfuras, Hand of Ragnaros', 1, 100),
		Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 30),
		] 
		}


	describe '#update_quality' do
		def update_quality
			GildedRose.new(items).update_quality()
		end

		it 'does not change the name' do
			update_quality
			expect(items[0].name).to eq 'foo'
		end

		it 'at end of day lowers sellin' do
			update_quality
			expect(items[0].sell_in).to eq 9 
		end

		it 'at end of day lowers quality' do
			update_quality
			expect(items[0].quality).to eq 10
		end

		it 'at end of sell_in lowers quality twice as fast' do
			items[0].sell_in = 0
			update_quality
			expect(items[0].quality).to eq 8
		end

		it 'can not change quality to negative' do
			items[0].quality = 0
			update_quality
			expect(items[0].quality).to eq 0
		end

		it 'increase quality of Aged Brie instead lowering' do
			update_quality
			expect(items[AGED_BRIE].quality).to eq 11
		end

		it 'check that quality never more than 50' do
				items[AGED_BRIE].quality = 50
				update_quality
				expect(items[AGED_BRIE].quality).to eq 50
		end

		it ' check that Sulfuras legendary never has to be sold or decreases in quality' do
			update_quality
			expect(items[SULFURAS].quality).to eq 100
			expect(items[SULFURAS].sell_in).to eq 1 
		end

		it 'check that Backstage passes increase in quality as sell_in value approaches' do
			update_quality
			expect(items[BACKSTAGE_PASSES].quality).to eq 31
		end

		it 'check that backstage passes increases by 2 when less or equal 10 days' do
			update_quality
			update_quality
			expect(items[BACKSTAGE_PASSES].quality).to eq 33
		end

		it 'check that backstage passes increases by 3 when less or equal 5 days' do
			7.times{ update_quality }
			expect(items[BACKSTAGE_PASSES].sell_in).to eq 4
			expect(items[BACKSTAGE_PASSES].quality).to eq 44
		end

		it 'check that backstage passes quality drops to 0 after the concert' 
		it 'check that conjured items degrade in quality twice as fast as normal items'
	end
end
