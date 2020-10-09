class VentureCapitalist
    attr_reader :name, :total_worth
    # attr_accessor :total_worth
    @@all = []
    def initialize (name, total_worth)
        @name = name
        @total_worth = total_worth
        self.class.all << self
    end
    def self.tres_commas_club
        self.all.select { |capitalist| capitalist.total_worth > 1000000}
    end
    def self.all
        @@all
    end
    def offer_contract (startup_instance, investment_type, amount_invested)
        funding_round = FundingRound.new(startup_instance, self, amount_invested)
        funding_round.type = investment_type
    end
    def funding_rounds
        FundingRound.all.select{|funding_round| funding_round.venture_capitalist == self}
    end
    def portfolio
        startups = []
        self.funding_rounds.each do |funding_round|
            startups << funding_round.startup
        end
        startups.uniq
    end
    def biggest_investment
        investments = []
        self.funding_rounds.each do |funding_round|
            investments << funding_round.investment
        end
        investments.sort!
        self.funding_rounds.find do |funding_round|
            funding_round.investment == investments.last
        end
    end
    def invested (domain)
        correct_funding_round = self.funding_rounds.find do |funding_round| 
            funding_round.startup.domain == domain
        end
        correct_funding_round.startup.total_funds
    end
end