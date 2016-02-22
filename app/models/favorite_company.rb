class FavoriteCompany

  class << self
    def list(user_id)
      favorite_company = new(user_id)
      favorite_company.lookup
    end
  end

  def initialize(user_id)
    @user_id = user_id
  end

  def lookup
    Company
      .joins(:details, :achievements, :user_company_maps)
      .select("companies.company_number, companies.name, achievements.*, details.*")
      .where(%Q|
        user_company_maps.user_id = #{@user_id} AND
        user_company_maps.company_type = 0 AND
        achievements.publish_year = ?|, Time.current.year - 1
      )
  end
end
