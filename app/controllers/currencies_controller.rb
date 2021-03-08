class CurrenciesController < ApplicationController
  before_action :load_currency, only: %i[index]

  def index
  end

  private

  def load_currency
    # достаём одну запись
    @currency = Currency.find_by(currency_from: 'USD',
                                 currency_to: 'RUB')
    if @currency.present?
      @mock = Mock.last
      if @mock.present?
        @currency.rate = @mock.rate
      end
    end
  end
end
