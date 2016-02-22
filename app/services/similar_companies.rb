module SimilarCompanies

  class Jpn
    class << self
      def extract(company_repository, count:)
        similar_companies = new(company_repository)
        details = similar_companies.extract_details
        similar_companies.lookup_companies_from(details).limit(count)
      end
    end

    attr_accessor :company_repository

    def initialize(company_repository)
      @company_repository = company_repository
    end

    def extract_details
      refine_by_industry
        .order_by_similar_market_value(@company_repository.detail)
        .exclude_me(@company_repository.detail.company_number)
    end

    def lookup_companies_from(details)
      Company.where(company_number: details.pluck(:company_number))
    end

  private
    def refine_by_industry
      Detail.lookup_industry(@company_repository.detail.industry_id)
    end
  end

  class Us
    class << self
      def extract(company_repository, count:)
        similar_companies = new(company_repository)
        similar_companies.extract_companies(count)
      end
    end

    attr_accessor :company_repository

    def initialize(company_repository)
      @company_repository = company_repository
    end

    def extract_companies(count)
      UsCompany.similar_companies(@company_repository.company, count)
    end
  end
end
