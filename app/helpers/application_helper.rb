module ApplicationHelper

  def check_minus(str)
    str =~ /^-[0-9]/ ?
      ("<span style='color: red;'>" + str + "</span>").html_safe :
      str
  end

  def dollar_to_yen(number)
    if I18n.locale == :ja
      yen_rate = number * 120
      (yen_rate / 1000000).to_s.reverse.gsub( /(\d{3})(?=\d)/, '\1,' ).reverse
    else
      (number / 1000000).to_s.reverse.gsub( /(\d{3})(?=\d)/, '\1,' ).reverse
    end
  end

  def yen_to_dollar(number)
    if I18n.locale == :ja
      number.to_s.reverse.gsub( /(\d{3})(?=\d)/, '\1,' ).reverse
    else
      (number / 120).to_s.reverse.gsub( /(\d{3})(?=\d)/, '\1,' ).reverse
    end
  end

  def comma(number)
    number.to_s.reverse.gsub( /(\d{3})(?=\d)/, '\1,' ).reverse
  end

  def zero_to_hyphen(number)
    number == '0' ? '---' : number
  end

  def last_year
    Time.now.year - 1
  end

  def indexes
    {
      sale: I18n.t('common.bases.sale'),
      operating_profit: I18n.t('common.bases.operating_profit'),
      ordinary_profit: I18n.t('common.bases.ordinary_profit'),
      net_income: I18n.t('common.bases.net_income')
    }
  end
end
