require 'rails_helper'

RSpec.describe CbrRatesService, type: :service do
  it 'returns valid ExchangeRate value' do
    returned_value = CbrRatesService.call

    exchange_rate = ExchangeRate.new(
      from_type: 'USD',
      to_type: 'RUR',
      value: returned_value,
      expires_at: 1.day.from_now
    )

    expect(exchange_rate).to be_valid
  end
end
