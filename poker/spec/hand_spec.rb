require 'rspec'
require 'hand'

describe "Hand" do
    let(:card) { double("card") }
    let (:card2) { double("card") }
    subject(:hand) { Hand.new }
    describe "#draw" do
        it "can add cards to itself" do
            hand.draw(card)
            expect(hand.length).to eq(1)
        end

        it "returns an error when the hand is full" do
            5.times { hand.draw(card) }
            expect { hand.draw(card) }.to raise_error(StandardError)
        end
    end

    describe "#discard" do
        it "discards the chosen card" do
            hand.draw(card)
            hand.discard(card)
            expect(hand.length).to eq(0)
        end

        it "returns an error when the hand is empty" do
            expect { hand.discard(card) }.to raise_error(StandardError)
        end

        it "returns an error when discarding a card that is not in hand" do
            hand.draw(card)
            expect { hand.discard(card2) }.to raise_error(ArgumentError)
        end
    end

    # describe "#value" do
    #     it "Assigns the value of the cards to itself, with high-card"
    #         allow(card).to receive(:initialize).with(:Diamond, 1)
    #         expect { hand.value }.to eq([13, 1])
    #     end
    # end
    
    # describe "#<=>" do
    #     it "uses comparitive operators to check the value against other hands"
    # end
end