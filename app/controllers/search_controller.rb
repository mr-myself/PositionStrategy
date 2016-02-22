class SearchController < ApplicationController

  def index
  end

  def extract
    search = Search.extract(params[:name])
    jpn_company_path(search.jpn_company.first) and return if search.jpn_company.present?
    us_company_path(search.us_company.first) and return if search.us_company.present?

    flash[:alert] = I18n.t('flash.no_company_data')
    redirect_to :back
  end

  def jpn_company_names
    render json: { success: true, resources: Company.pluck(:name) }, status: 200
  end

  def us_company_names
    render json: { success: true, resources: UsCompany.pluck(:name) }, status: 200
  end

  def all_company_names
    render json: {
      success: true,
      resources: [Company.pluck(:name), UsCompany.pluck(:name)].flatten
    }, status: 200
  end

private
  def jpn_company_path(company)
    redirect_to jpn_path(number: company.company_number)
  end

  def us_company_path(company)
    redirect_to us_path(symbol: company.symbol)
  end
end
