class ExchangeRate < ApplicationRecord
  validates :from_type, presence: true
  validates :to_type, presence: true
  validates :value, numericality: { greater_than: 0 }
  validate :expiration_date_cannot_be_in_the_past

  after_commit :schedule_expiration, if: -> { expires_at.present? }
  after_commit :broadcast_rate

  def expiration_date_cannot_be_in_the_past
    if expires_at.present? && expires_at < Time.now
      errors.add(:expires_at, 'cannot be in the past')
    end
  end

  def broadcast_rate
    ActionCable.server.broadcast("rates", value)
  end

  def schedule_expiration
    RatesUpdaterJob.set(wait_until: expires_at).perform_later
  end
end
