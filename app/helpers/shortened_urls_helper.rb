module ShortenedUrlsHelper
  def short_url_for(shortened_url)
    "#{request.base_url}/#{shortened_url.token}"
  end
end
