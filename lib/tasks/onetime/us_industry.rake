namespace :us_industry do

  desc 'industryを作成'
  task create: :environment do
    html = Formatter::Url.build("https://biz.yahoo.com/ic/ind_index.html")
    UsIndustry.create(id: 1, name: 'Others')
    html.css('table[2] > tr > td > table > tr > td > table > tr > td > table > tr').each do |element|
      name =  element.css('td > font > a').text.gsub(/[\r\n]/,"\s")
      UsIndustry.create(name: name) if name.match(/.+?/)
    end
  end
end
