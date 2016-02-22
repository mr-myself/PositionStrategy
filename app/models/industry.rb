class Industry

  def self.belonging_companies_in(industry_id)
    Detail.lookup_industry(industry_id)
  end
end
