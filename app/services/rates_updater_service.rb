# frozen_string_literal: true

class RatesUpdaterService < ApplicationService
  attr_reader :fresh_rate

  def initialize(fresh_rate)
    @fresh_rate = fresh_rate
  end

  def call
    ExchangeRate.find_by(
      from_type: 'USD',
      to_type: 'RUR',
      expires_at: [..Time.now, nil]
    )&.update(value: fresh_rate, expires_at: nil)
  end
end
