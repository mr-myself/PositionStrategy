class Jpn::IndustriesController < ApplicationController

  def index
  end

  def show
    request.smart_phone? ? show_for_sp : show_for_pc
  end

  def companies
    @companies = CompaniesInIndustry::Jpn.all(params[:id]).page(params[:page]).per(20)
  end

  def ranking_of_basis
    render json: Ranking::Jpn.by_(params[:basis],
      industry_id: params[:id],
      ranking_count: 5
    )
  end

  def annual_average
    render json: {
      success: true,
      resources: AverageCalculator::Jpn.annual_average_in(params[:id], year: Time.now.year - 1)
    }, status: 200
  end

  def each_year_averages
    company_repository = CompanyRepository::Jpn.find(params[:company_number])
    years = company_repository.achievements.pluck(:publish_year).sort
    averages = AverageCalculator::Jpn.each_years_average_in(params[:id], years)
    render json: { success: true, resources: averages }, status: 200
  end

private
  def show_for_pc
    @best_ten = Ranking::Jpn.by_('sale', industry_id: params[:id], ranking_count: 10)
    gon.industry_average = AverageCalculator::Jpn.annual_average_in(params[:id], year: Time.now.year - 1)
  end

  def show_for_sp
    %w(sale operating_profit ordinary_profit net_income).each do |basis|
      eval("
        gon.average_#{basis} = Ranking::Jpn.by_(
          basis, industry_id: params[:id], ranking_count: 5
        )
      ")
    end

    @best_ten = Ranking::Jpn.by_('sale', industry_id: params[:id], ranking_count: 10)
    @sale = gon.average_sale
    @operating_profit = gon.average_operating_profit
    @ordinary_profit = gon.average_ordinary_profit
    @net_income = gon.average_net_income
  end
end
