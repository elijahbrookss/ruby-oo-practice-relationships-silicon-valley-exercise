class Startup
    @@all = []
    attr_reader :founder, :domain, :name
    def initialize (founder, domain, name)
        @founder = founder
        @domain = domain
        @name = name
        self.class.all << self
    end
    def pivot(domain, name)
        @domain = domain
        @name = name
    end
    def self.all
        @@all
    end
    def self.find_by_founder(founder_name)
        self.all.find{|startup| startup.founder == founder_name }
    end
    def self.domains
        domains = []
        self.all.each{|startup| domains << startup.domain}
        domains
    end
    def sign_contract(venture_capitalist_instance, investment_type, amount_invested)
        fund_round = FundingRound.new(self, venture_capitalist_instance, amount_invested)
        fund_round.type = investment_type
    end
    def funding_rounds
        funding_rounds =  FundingRound.all.select{|funding_round| funding_round.startup == self}
    end
    def num_funding_rounds
    #    funding_rounds =  FundingRound.all.select{|funding_round| funding_round.startup == self}
        self.funding_rounds
        funding_rounds.length
    end
    def total_funds
        funding_amounts = []
        FundingRound.all.each do |funding_round|
            if funding_round.startup == self
                funding_amounts << funding_round.investment
                # binding.pry
            end
        end
        funding_amounts.sum
    end
    def investors
        temp_array = FundingRound.all.select do |funding_round|
            funding_round.startup == self
        end
        investors = []
        temp_array.each do |my_funding_rounds|
            investors << my_funding_rounds.venture_capitalist
        end
        investors.uniq
    end
    def big_investors
        big_investors = []
        tres_commas_club = VentureCapitalist.tres_commas_club
        self.investors.each do |investor|
            if tres_commas_club.include?(investor)
                big_investors << investor
            end
        end
        big_investors.uniq
    end
end