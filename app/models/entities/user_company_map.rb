class UserCompanyMap < ActiveRecord::Base
  belongs_to :user
  belongs_to :company, foreign_key: :company_number

  scope :favorites, ->(user_id) { where(user_id: user_id, company_type: PSConfig.company_type.favorite) }

  class << self
    def lookup_my_company(user_id)
      find_by(user_id: user_id, company_type: PSConfig.company_type.my_company)
    end

    def create_or_update_with(user_id, company_number)
      if lookup_my_company(user_id)
        add_my_company(user_id, company_number)
      else
        update_my_company(user_id, company_number)
      end
    end

    def add_my_company(user_id, company_number)
      create(
        user_id: user_id,
        company_number: company_number,
        company_type: PSConfig.company_type.my_company
      )
    end

    def update_my_company(user_id, company_number)
      my_company = find_by(user_id: user_id, company_type: PSConfig.company_type.my_company)
      my_company.update_attributes(company_number: company_number)
    end

    def add_or_remove_favorite(user_id, company_number)
      ''.tap do |message|
        if favorites(user_id).where(company_number: company_number).blank?
          create(
            user_id: user_id,
            company_number: company_number,
            company_type: PSConfig.company_type.favorite
          )
          message << 'add'
        else
          delete_all(
            user_id: user_id,
            company_number: company_number,
            company_type: PSConfig.company_type.favorite
          )
          message << 'remove'
        end
      end
    end
  end
end
