require "byebug"
class Hand
    def initialize
        @cards = []
    end

    def length
        @cards.length
    end

    def draw(card)
        if self.length == 5
            raise "Hand is already full"
        end
        @cards << card
    end

    def discard(card)
        if self.length == 0
            raise "The hand is empty!"
        end

        if !@cards.include?(card)
            raise ArgumentError.new "That card is not in the hand"
        end

        @cards.delete(card)
    end

    def value
        # debugger
        high_card = @cards.map { |cards| cards.value }.sort[-1]
        val = [high_card]

        if self.royal? && self.flush?
            val.unshift(9)
        elsif self.flush? && self.straight?
            val.unshift(8)
        elsif self.four?
            val.unshift(7)
        elsif self.full_house?
            val.unshift(6)
        elsif self.flush?
            val.unshift(5)
        elsif self.straight?
            val.unshift(4)
        elsif self.three?
            val.unshift(3)
        elsif self.two_pair?
            val.unshift(2)
        elsif self.pair?
            val.unshift(1)
        else
            val.unshift(0)
        end

        return val
    end

    def ==(hand)
        if self.value[0] == hand.value[0]
            return true if self.value[1] == hand.value[1]
        end
        false
    end

    def >(hand)
        if self.value[0] > hand.value[0]
            return true
        elsif self.value[0] == hand.value[0]
            return true if self.value[1] > hand.value[1]
        end
        false
    end

    def <(hand)
        if self.value[0] < hand.value[0]
            return true
        elsif self.value[0] == hand.value[0]
            return true if self.value[1] < hand.value[1]
        end
        false
    end

    private
    def royal?
        if @cards.map { |cards| cards.value}.sort == [10, 11, 12, 13, 14]
            return true
        end
        false
    end

    def full_house?
        count = Hash.new(0)
        @cards.map { |cards| cards.value}.each do |val|
            count[val] += 1
        end

        return true if count.has_value?(3) && count.has_value?(2)
        false
    end

    def flush?
        @cards.all?{ |card| card.suit == @cards[0].suit}
    end

    def straight?
        values = @cards.map { |cards| cards.value }
        return true if values.max - values.min == 4
        return true if values == [2, 3, 4, 5, 14]
        false
    end

    def pair?
        count = Hash.new(0)
        @cards.map { |cards| cards.value}.each do |val|
            count[val] += 1
        end

        return true if count.has_value?(2)
    end

    def two_pair?
        count = Hash.new(0)
        @cards.map { |cards| cards.value}.each do |val|
            count[val] += 1
        end

        pair_count = 0
        count.each_value do |val|
            pair_count += 1 if val == 2
        end

        return true if pair_count > 1
        false
    end

    def three?
        count = Hash.new(0)
        @cards.map { |cards| cards.value}.each do |val|
            count[val] += 1
        end

        return true if count.has_value?(3)
        false
    end

    def four?
        count = Hash.new(0)
        @cards.map { |cards| cards.value}.each do |val|
            count[val] += 1
        end

        return true if count.has_value?(4)
        false
    end
end