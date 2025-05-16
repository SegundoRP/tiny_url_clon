class ShortenedUrl < ApplicationRecord
  has_many :visits, dependent: :destroy_async

  validates :full_url, :token, presence: true
  validates :token, uniqueness: true

  validate :validate_full_url

  def persist_with_random_token!(attempts = 10)
    attempts.times do |i|
      self.token = SecureRandom.urlsafe_base64(6).gsub(/[_-]/, '')
      save!
      return true
    rescue ActiveRecord::RecordNotUnique
      Rails.logger.warn(I18n.t('shortened_urls.token_collision', number: i + 1))
    rescue ActiveRecord::RecordInvalid
      return false
    end

    errors.add(:token, I18n.t('activerecord.errors.models.shortened_url.attributes.token.retry_failed'))
    false
  end

  private

  def validate_full_url
    uri = URI.parse(full_url)
    unless full_url.match?(/^https?:\/\//) && (uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS))
      errors.add(:full_url, I18n.t('activerecord.errors.models.shortened_url.attributes.full_url.invalid'))
    end
  rescue URI::InvalidURIError
    errors.add(:full_url, I18n.t('activerecord.errors.models.shortened_url.attributes.full_url.invalid'))
  end
end
