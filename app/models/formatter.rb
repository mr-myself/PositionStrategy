require 'open-uri'
require 'csv'

module Formatter
  class Excel

    def initialize(path)
      @path = path
    end

    def build
      Spreadsheet.client_encoding = 'UTF-8'
      Spreadsheet.open @path
    end
  end

  class Csv

    def self.build(path)
      CSV.read path
    end
  end

  class Url

    def self.build(path)
      begin
        Nokogiri::HTML(open(path))
      rescue => e
        p e
        Rails.logger.info("Formatter::Url #{e.message}")
        false
      end
    end
  end
end
