require 'rails_helper'

RSpec.describe RatesUpdaterService, type: :service do
  ActiveJob::Base.queue_adapter = :test
  
  it 'updates exchange rate without explicit expiration date' do
    old_rate = 10
    expired_rate = ExchangeRate.create!(
      from_type: 'USD',
      to_type: 'RUR',
      value: old_rate,
      expires_at: nil
    )

    fresh_rate = 20
    RatesUpdaterService.call(fresh_rate)

    expect(expired_rate.reload.value).to eq(fresh_rate)
  end

  it 'updates expired exchange rate' do
    old_rate = 10
    expired_rate = ExchangeRate.create!(
      from_type: 'USD',
      to_type: 'RUR',
      value: old_rate,
      expires_at: 1.day.from_now
    )

    fresh_rate = 20
    allow(Time).to receive(:now).and_return(2.days.from_now)
    RatesUpdaterService.call(fresh_rate)

    expect(expired_rate.reload.value).to eq(fresh_rate)
  end
end
