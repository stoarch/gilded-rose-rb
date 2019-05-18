require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
	let(:items) { [Item.new('foo', 10, 11)] }
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

		it 'can not change quality to negative'
		it 'increase quality of Aged Brie instead lowering'
		it 'check that quality never more than 50'
		it ' check that Sulfuras legendary never has to be sold or decreases in quality'
		it 'check that Backstage passesincrease in quality as sell_in value approaches'
		it 'check that backstage passes increases by 2 when less or equal 10 days'
		it 'check that backstage passes increases by 3 when less or equal 5 days'
		it 'check that backstage passes quality drops to 0 after the concert' 
		it 'check that conjured items degrade in quality twice as fast as normal items'
	end
end
