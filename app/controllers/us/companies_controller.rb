class Us::CompaniesController < ApplicationController

  def show
    @company_repository = CompanyRepository::Us.find(params[:symbol])
    @competitors = CompetitorRepository::Us.lookup(params[:symbol])
    @similar_companies = SimilarCompanies::Us.extract(@company_repository, count: 10)

    gon.company_names = UsCompany.pluck(:name)
    gon.company_repository = @company_repository
    gon.average = UsAverage.lookup_sector(@company_repository.company.sector_id).first
  end

  def compare
    return if request.smart_phone?

    @company_repository = CompanyRepository::Us.find(params[:symbol])
    @compare_company = CompanyRepository::Us.find(params[:compare])
    @competitors = CompetitorRepository::Us.lookup(params[:symbol])
    @similar_companies = SimilarCompanies::Us.extract(@company_repository, count: 10)

    gon.company_repository = @company_repository
    gon.compare = @compare_company.achievements.last
    gon.compare_periods = Compare::Us.set(
      @compare_company.achievements.pluck(:publish_day),
      @compare_company.achievements
    )
  end

  def search_for_compare
    search = Search.extract(params[:name])
    if search.us_company.present?
      redirect_to us_compare_path(
        symbol: params[:symbol],
        compare: search.us_company.first.symbol
      ) and return
    else
      flash[:alert] = I18n.t('flash.no_company_data')
      redirect_to :back
    end
  end

  def achievements
    company_repository = CompanyRepository::Us.find(params[:symbol])
    render json: company_repository.achievements
  end
end
