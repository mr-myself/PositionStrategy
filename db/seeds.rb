Company.create(
  :id          => 1,
  :name        => 'Google',
  :number      => 1234,
  :market_type => 1,
)

Detail.create(
  :id            => 1,
  :company_id    => 1,
  :employee      => 100,
  :industry_id   => 1,
  :settling_day  => "2013/01/01",
  :age           => 30,
  :annual_income => 1000,
)

Industry.create(
  :id   => 1,
  :name => 'IT',
)

Achievement.create(
  :company_id       => 1,
  :date             => "2013/01/01",
  :sale             => 1000,
  :operating_profit => 500,
  :ordinary_profit  => 200,
  :net_income       => 100,
  :market_value     => 10000,
)
