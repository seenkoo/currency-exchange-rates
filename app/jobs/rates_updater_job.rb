class RatesUpdaterJob < ApplicationJob
  def perform(*_args)
    fresh_rate = CbrRatesService.call
    ExchangeRate.find_by(
      from_type: 'USD',
      to_type: 'RUR',
      expires_at: [..Time.now, nil]
    )&.update(value: fresh_rate, expires_at: nil)
  end
end
