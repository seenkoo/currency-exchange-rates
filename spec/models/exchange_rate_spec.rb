require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  ActiveJob::Base.queue_adapter = :test

  it 'is valid without explicit expiration date' do
    exchange_rate = ExchangeRate.new(
      from_type: 'USD',
      to_type: 'RUR',
      value: 10
    )

    exchange_rate.expires_at = nil
    expect(exchange_rate).to be_valid
  end

  it 'is valid with expiration date in the future' do
    exchange_rate = ExchangeRate.new(
      from_type: 'USD',
      to_type: 'RUR',
      value: 10
    )

    future_expiration_date = 1.day.from_now
    exchange_rate.expires_at = future_expiration_date
    expect(exchange_rate).to be_valid
  end

  it 'is not valid with expiration date in the past' do
    exchange_rate = ExchangeRate.new(
      from_type: 'USD',
      to_type: 'RUR',
      value: 10
    )
    
    past_expiration_date = 1.day.ago
    exchange_rate.expires_at = past_expiration_date
    expect(exchange_rate).to_not be_valid
  end

  it 'schedules RatesUpdaterJob at its expiration date after commit' do
    expiration_date = 1.day.from_now
    exchange_rate = ExchangeRate.new(
      from_type: 'USD',
      to_type: 'RUR',
      value: 10,
      expires_at: expiration_date
    )

    expect {
      exchange_rate.save
    }.to have_enqueued_job(RatesUpdaterJob).at(expiration_date)
  end
end
