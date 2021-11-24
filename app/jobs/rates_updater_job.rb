class RatesUpdaterJob < ApplicationJob
  def perform(*_args)
    fresh_rate = CbrRatesService.call
    RatesUpdaterService.call(fresh_rate)
  end
end
