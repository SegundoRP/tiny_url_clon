class ShortenedUrl < ApplicationRecord
  has_many :visits, dependent: :destroy_async

  validates :full_url, presence: true
  validates :token, uniqueness: true

  after_create :generate_token!
  validate :validate_full_url

  private

  def validate_full_url
    uri = URI.parse(full_url)
    unless full_url.match?(/^https?:\/\//) && (uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS))
      errors.add(:full_url, I18n.t('activerecord.errors.models.shortened_url.attributes.full_url.invalid'))
    end
  rescue URI::InvalidURIError
    errors.add(:full_url, I18n.t('activerecord.errors.models.shortened_url.attributes.full_url.invalid'))
  end

  def generate_token!
    update_column(:token, Base62.encode(id)) if saved_change_to_id?
  end
end
