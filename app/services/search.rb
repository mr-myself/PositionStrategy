class Search

  class << self
    def extract(name)
      search = new(name)
      search.set_company
      search
    end
  end

  attr_accessor :jpn_company, :us_company

  def initialize(name)
    @name = name
    @jpn_company = nil
    @us_company = nil
  end

  def set_company
    jpn_company
    us_company
  end

  def jpn_company
    @jpn_company = Company.lookup(@name)
  end

  def us_company
    @us_company = UsCompany.lookup(@name)
  end
end
