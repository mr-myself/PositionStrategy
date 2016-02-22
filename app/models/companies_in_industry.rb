class CompaniesInIndustry

  class Jpn
    class << self
      def all(industry_id)
        companies = Detail.lookup_industry(industry_id).pluck(:company_number)
        Company.select(:id, :name, :company_number)
          .where(company_number: companies)
          .group(:id).order(:name)
      end
    end
  end

  class Us
    class << self
      def all(sector_id)
        UsCompany.select(:id, :name, :symbol)
        .refine_sector(sector_id).order(:name)
      end
    end
  end
end
