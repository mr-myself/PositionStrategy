class MypageController < ApplicationController
  before_action :sign_in?

  def index
    @favorite_companies = FavoriteCompany.list(current_user.id)
    gon.favorite_companies = @favorite_companies
    set_my_company
  end

  def profile_edit_smart_phone
    mypage_path and return unless request.smart_phone?
    @company_repository = CompanyRepository::Jpn.find_my_company(current_user.id)
  end

private
  def sign_in?
    redirect_to new_user_path and return unless logged_in?
    @my_company = CompanyRepository::Jpn.find_my_company(current_user.id)
  end

  def set_my_company
    return unless current_user.my_company

    @company_repository = CompanyRepository::Jpn.find_my_company(current_user.id)
    gon.my_company = @company_repository
    gon.average = AverageCalculator.annual_average_in(@company_repository.detail.industry_id, year: Time.now.year - 1)
  end
end
