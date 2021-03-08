class MocksController < ApplicationController
  before_action :load_mock, only: %i[new update]

  def new
  end

  def create
    @mock = Mock.new(mock_params)
    localize_timezone

    if @mock.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @mock.update(mock_params)
      localize_timezone
      @mock.save
      deferred_task(@mock)
    end
    redirect_to root_path
  end

  private

  def load_mock
    @mock = Mock.last

    if @mock.blank?
      @currency = Currency.find_by(currency_from: 'USD',
                               currency_to: 'RUB')
      @mock = Mock.new(rate: @currency.rate) if @currency.present?
    end

    if @mock.blank?
      @mock = Mock.new
    end
  end

  def mock_params
    params.require(:mock).permit(:rate, :at_time)
  end

  def deferred_task(mock)
    # Mock.find(mock.id).destroy
    puts("Time.now = #{Time.now.inspect}")
    puts("@mock.at_time = #{@mock.at_time.inspect}")
    if Time.now < @mock.at_time
      puts("@mock = #{@mock.inspect}")
      # Resque.enqueue_at(@mock.at_time, ForsingJob, id: @mock.id)
      # Resque.enqueue_at(10.seconds.from_now, ForsingJob, id: @mock.id)
    end
  end

  def localize_timezone
    @mock.at_time = @mock.at_time.asctime.in_time_zone("Moscow")
  end
end
