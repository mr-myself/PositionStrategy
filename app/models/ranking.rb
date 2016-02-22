class Ranking

  class Jpn
    class << self
      def by_(basis, industry_id:, ranking_count:)
        ranking = new(industry_id)
        ranking.extract_top(basis, ranking_count)
      end
    end

    def initialize(industry_id)
      @industry_id = industry_id
    end

    def company_numbers_in_industry
      Industry.belonging_companies_in(@industry_id).pluck(:company_number)
    end

    def extract_top(order_basis, ranking_count)
      Company
        .joins(:achievements, :details)
        .select("companies.*, achievements.*, details.*")
        .where("achievements.publish_year = ?", (Time.now.year - 1))
        .where("companies.company_number IN (?)", company_numbers_in_industry)
        .order("#{order_basis} DESC").limit(ranking_count)
    end
  end

  class Us
    class << self
      def by_(basis, sector_id:, ranking_count:)
        ranking_us = new
        ranking_us.extract_top(sector_id, basis, ranking_count)
      end
    end

    def extract_top(sector_id, order_basis, ranking_count)
      UsCompany
        .joins("INNER JOIN us_achievements ON us_companies.symbol = us_achievements.symbol")
        .select("us_achievements.*, us_companies.*")
        .refine_sector(sector_id)
        .where("us_achievements.period_type = 1")
        .order("#{order_basis} DESC").limit(ranking_count)
    end
  end
end
