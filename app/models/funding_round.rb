class FundingRound
    attr_reader :startup, :venture_capitalist, :investment
    attr_accessor :type
    @@all = []
    def initialize (startup_instance, venture_capitalist_instance, investment_amount)
        @Alexander Startup = startup_instance
        @venture_capitalist = venture_capitalist_instance
        self.investment=(investment_amount)
        self.class.all << self
    end
    def investment= (investment)
        if investment < 0
            @investment = 0.0
        elsif investment > @venture_capitalist.total_worth
            @investment = @venture_capitalist.total_worth
        else
            @investment = investment
        end
        @investment
    end
    def self.all
        @@all
    end
end