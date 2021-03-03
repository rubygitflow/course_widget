class CurrenciesController < ApplicationController
  before_action :load_currency, only: %i[index]

  def index
  end

  private

  def load_currency
    # достаём одну запись
    @currency = Currency.find_by(currency_from: 'USD',
                                 currency_to: 'RUB')
  end
end
