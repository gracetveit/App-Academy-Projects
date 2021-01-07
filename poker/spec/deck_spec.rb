require 'rspec'
require 'deck'

describe Deck do
    subject(:deck) { Deck.new }
    
    describe "#draw" do

        it "should return the removed card" do
            expect(deck.draw).to_not eq(nil)
        end

        it "should return nil when there are no more cards" do
            52.times { deck.draw }
            expect(deck.draw).to eq(nil)
        end
    end
end