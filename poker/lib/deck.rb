require 'card'

class Deck
    def initialize
        @cards = []
        suits = [
            :Heart,
            :Spade,
            :Diamond,
            :Club
        ]
        13.times do |i|
            num = 1
            suits.each do |suit|
                @cards << Card.new(suit, num)
            end
            num += 1
        end
        self.shuffle
    end

    def draw
        @cards.pop
    end

    private
    def shuffle
        @cards.shuffle!
        nil
    end
end