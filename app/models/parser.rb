module Parser
  TOSHO_FIRST_EXCEL_PATH = Rails.root + "misc/spreadsheets/20151230_tosho_first.xls"
  TOSHO_SECOND_EXCEL_PATH = Rails.root + "misc/spreadsheets/20151230_tosho_second.xls"
  MOTHERS_EXCEL_PATH = Rails.root + "misc/spreadsheets/20151230_mothers.xls"
  NASDAQ_EXCEL_PATH = Rails.root + "misc/spreadsheets/20160127_nasdaq_list.csv"
  NYSE_EXCEL_PATH = Rails.root + "misc/spreadsheets/20160127_nyse_list.csv"

  def self.tosho_first
    excel_formatter = Formatter::Excel.new(TOSHO_FIRST_EXCEL_PATH)
    [].tap do |t|
      (excel_formatter.build.worksheet 0).each_with_index do |row, i|
        next if i == 0
        t << Company.new(
          name: row[2],
          company_number: row[1].to_i,
          market_type: PSConfig.market.tosho_first
        )
      end
    end
  end

  def self.tosho_second
    excel_formatter = Formatter::Excel.new(TOSHO_SECOND_EXCEL_PATH)
    [].tap do |t|
      (excel_formatter.build.worksheet 0).each_with_index do |row, i|
        next if i == 0
        t << Company.new(
          name: row[2],
          company_number: row[1].to_i,
          market_type: PSConfig.market.tosho_second
        )
      end
    end
  end

  def self.mothers
    excel_formatter = Formatter::Excel.new(MOTHERS_EXCEL_PATH)
    [].tap do |t|
      (excel_formatter.build.worksheet 0).each_with_index do |row, i|
        next if i == 0
        t << Company.new(
          name: row[2],
          company_number: row[1].to_i,
          market_type: PSConfig.market.mothers
        )
      end
    end
  end

  def self.nyse
    header, *records = Formatter::Csv.build(NYSE_EXCEL_PATH)
    [].tap do |t|
      records.each.with_index(0) do |row, i|
        next if i == 0

        sector_id, industry_id = Parser::Us::SectorAndIndustry.get(row[0])
        t << UsCompany.new(
          symbol:       row[0].strip,
          name:         row[1].strip,
          sector_id:    sector_id,
          industry_id:  industry_id,
          market_value: row[3].strip,
          market_type:  1
        )
      end
    end
  end

  def self.nasdaq
    header, *records = Formatter::Csv.build(NASDAQ_EXCEL_PATH)
    [].tap do |t|
      records.each.with_index(0) do |row, i|
        next if i == 0

        sector_id, industry_id = Parser::Us::SectorAndIndustry.get(row[0].strip)
        t << UsCompany.new(
          symbol:       row[0].strip,
          name:         row[1].strip,
          sector_id:    sector_id,
          industry_id:  industry_id,
          market_value: row[3].strip,
          market_type:  2
        )
      end
    end
  end
end
