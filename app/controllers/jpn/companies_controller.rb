class Jpn::CompaniesController < ApplicationController
  before_action :set_my_company, only: [:show, :compare]
  before_action :has_favorites?, only: [:show, :compare]

  def show
    @company_repository = CompanyRepository::Jpn.find(params[:number])
    @similar_companies = SimilarCompanies::Jpn.extract(@company_repository, count: 10)
    gon.achievement = @company_repository.achievements
  end

  def compare
    return if request.smart_phone?

    @company_repository = CompanyRepository::Jpn.find(params[:number])
    @compare_company = CompanyRepository::Jpn.find(params[:compare])
    @similar_companies = SimilarCompanies::Jpn.extract(@company_repository, count: 10)
    gon.achievement = @company_repository.achievements
    gon.compare = @compare_company.achievements.last
    gon.compare_periods = Compare::Jpn.set(
      @company_repository.achievements.pluck(:publish_day),
      @compare_company.achievements
    )
  end

  def search_for_compare
    search = Search.extract(params[:name])
    if search.jpn_company.present?
      redirect_to jpn_compare_path(
        number: params[:number],
        compare: search.jpn_company.first.company_number
      ) and return
    else
      flash[:alert] = I18n.t('flash.no_company_data')
      redirect_to :back
    end
  end

  def add_favorite
    render json: {
      success: UserCompanyMap.add_or_remove_favorite(
        current_user.id, params[:company_number]
      )
    }
  end

private

  def set_my_company
    return unless logged_in? and current_user.my_company

    @my_company = CompanyRepository::Jpn.find(current_user.my_company)
    gon.my_company = @my_company.achievements
  end

  def has_favorites?
    return unless logged_in?

    @has_favorites_flag =
      UserCompanyMap
      .favorites(current_user.id)
      .where(company_number: params[:number])
      .present?
  end
end
