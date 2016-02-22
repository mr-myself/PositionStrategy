class MyCompany

  class << self
    def find_by(user_id)
      my_company = new(user_id)
      my_company.find
    end

    def save(user, company_name)
      if company = Search.extract(params[:name]).jpn_company
        UserCompanyMap.create_or_update_with(user.id, company.company_number)
      else
        false
      end
    end
  end

  def initialize(user_id)
    @user_id = user_id
  end

  def find
    Company
      .joins(
        "INNER JOIN achievements ON companies.company_number = achievements.company_number",
        "INNER JOIN details ON companies.company_number = details.company_number",
        "INNER JOIN user_company_maps ON companies.company_number = user_company_maps.company_number")
      .select("achievements.*, companies.name, companies.company_number, details.*")
      .where("user_company_maps.user_id = #{@user_id} AND user_company_maps.company_type = 1")
      .first
  end
end
