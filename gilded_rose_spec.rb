require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
	describe '#update_quality' do
		it 'does not change the name' do
			items = [Item.new('foo', 0, 0)]
			GildedRose.new(items).update_quality()
			expect(items[0].name).to eq 'foo'
		end

		it 'at end of day lowers sellin' do
			items = [Item.new('foo', 10, 11 )]			
			GildedRose.new(items).update_quality()
			expect(items[0].quality).to eq 10
		end

		it 'at end of day lowers quality'
		it 'at end of sell_in lowers quality twice as fast'
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
