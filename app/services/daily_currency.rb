class DailyCurrency
  def self.update
    Money.locale_backend = :currency
    usd = Money.new('1_00', 'USD') # 4 signs
    result = CbrRates.new.exchange(usd, 'RUB')
             .format(symbol: false, 
                     thousands_separator: "",
                     decimal_mark: ".")
    @currency = Currency.find_by(currency_from: 'USD',
                                 currency_to: 'RUB')
    if @currency.present?
      # Updating one record:
      Currency.update(@currency.id, rate: result)
    else
      # Creating a record:
      @currency = Currency.new(
        currency_from: 'USD',
        currency_to: 'RUB',
        resource: 'http://cbr.ru/scripts/XML_daily.asp')
      @currency.rate = result.to_f
      @currency.save
    end
  end
end
