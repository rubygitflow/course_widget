class MocksController < ApplicationController
  before_action :load_mock, only: %i[new update]

  def new
  end

  def create
    @mock = Mock.new(mock_params)
    localize_timezone

    if @mock.save
      run_deletion
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @mock.update(mock_params)
      localize_timezone
      @mock.save
      run_deletion
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

  def localize_timezone
    @mock.at_time = @mock.at_time.asctime.in_time_zone("Moscow")
  end

  def run_deletion
    if Time.now < @mock.at_time
      # clear history of tasks
      Delayed::Job.destroy_all
      puts('Delayed::Job.all.count =',Delayed::Job.all.count)
      # add new task
      Mock.delay(queue: "forcerate", 
                 run_at: @mock.at_time )
        .deferred_deletion(@mock.id)
    end
  end
end
