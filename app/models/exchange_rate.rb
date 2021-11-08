class ExchangeRate < ApplicationRecord
  validates :from_type, presence: true
  validates :to_type, presence: true
  validates :value, numericality: { greater_than: 0 }

  after_commit :schedule_expiration, if: -> { expires_at.present? }
  after_commit :broadcast_rate

  def broadcast_rate
    ActionCable.server.broadcast("rates", value)
  end

  def schedule_expiration
    RatesUpdaterJob.set(wait_until: expires_at).perform_later
  end
end
