class DeleteCompany

  module Jpn
    def self.execute(number)
      company_repository = CompanyRepository::Jpn.find(number)
      if company_repository.company.blank? or
         company_repository.detail.blank? or
         company_repository.achievements.blank?
        ActiveRecord::Base.transaction do
          Company.delete_all(company_number: number)
          Detail.delete_all(company_number: number)
          Achievement.delete_all(company_number: number)
        end
      end
    end
  end

  module Us
    def self.execute(symbol)
      company_repository = CompanyRepository::Us.find(symbol)
      if company_repository.company.blank? or
         company_repository.achievements.blank?
        ActiveRecord::Base.transaction do
          UsCompany.delete(company_repository.company[:id])
          UsAchievement.delete_all(symbol: symbol)
          UsCompetitor.delete_all(my_symbol: symbol)
        end
      end
    end
  end
end
