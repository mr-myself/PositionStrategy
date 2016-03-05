class CompanyRepository

  class Jpn
    class << self
      def find(company_number)
        new(company_number)
      end

      def find_my_company(user_id)
        MyCompany.find_by(user_id)
      end
    end

    attr_reader :company, :detail, :achievements

    def initialize(company_number)
      @company = Company.find_by(company_number: company_number)
      @detail = Detail.find_by(company_number: company_number)
      @achievements = Achievement
        .where(company_number: company_number)
        .order('achievements.publish_year ASC')
    end

    def oldest_period
      @achievements.first.publish_day
    end

    def latest_period
      @achievements.last.publish_day
    end
  end

  class Us
    class << self
      def find(symbol)
        new(symbol)
      end
    end

    attr_reader :company, :achievements

    def initialize(symbol)
      @company = UsCompany.find_by(symbol: symbol)
      @achievements = UsAchievement
        .where(symbol: symbol)
        .order('period_type ASC')
    end

    def lookup_competitors
      CompetitorRepository::Us.lookup(@company.symbol)
    end

    def oldest_period
      @achievements.first.publish_day
    end

    def latest_period
      @achievements.last.publish_day
    end
  end
end
