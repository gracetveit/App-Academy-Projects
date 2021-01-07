require 'rspec'
require 'card'

describe "Card" do
    subject(:card) {Card.new(:Spade, 1)}
    it "should have a suit" do
        expect(card.suit).to eq(:Spade)
    end
    it "should have a number" do
        expect(card.value).to eq(1)
    end
end