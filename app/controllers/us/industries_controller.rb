class Us::IndustriesController < ApplicationController

  def index
  end

  def show
    request.smart_phone? ? show_for_sp : show_for_pc
  end

  def companies
    @companies = CompaniesInIndustry::Us.all(params[:id]).page(params[:page]).per(20)
  end

  def ranking_of_basis
    render json: Ranking::Us.by_(params[:basis],
      sector_id: params[:id],
      ranking_count: 5
    )
  end

  def each_year_averages
    render json: UsAverage.lookup_sector(params[:id]).pluck(params[:basis])
  end

private
  def show_for_pc
    @period = UsAchievement.where(period_type: 1).first.publish_day
    @best_ten = Ranking::Us.by_('sale', sector_id: params[:id], ranking_count: 10)
    gon.industry_average = UsAverage.lookup_sector(params[:id]).lookup_period(1).first
  end

  def show_for_sp
    %w(sale operating_profit net_income).each do |basis|
      eval("
        gon.average_#{basis} = Ranking::Us.by_(basis, sector_id: params[:id], ranking_count: 5)
      ")
    end

    @best_ten = Ranking::Us.by_('sale', sector_id: params[:id], ranking_count: 10)
    @sale = gon.average_sale
    @operating_profit = gon.average_operating_profit
    @net_income = gon.average_net_income
  end
end
