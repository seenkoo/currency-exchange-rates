class RatesUpdaterJob < ApplicationJob
  def perform(*args)
    rates = CbrRatesService.call
    ActionCable.server.broadcast("rates", rates)
  end
end
