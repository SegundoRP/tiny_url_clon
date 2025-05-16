require 'rails_helper'

RSpec.describe ShortenedUrl, type: :model do
  describe "ShortUrl" do
    let(:shortened_url) { create(:shortened_url) }

    it "finds a shortened_url with the token" do
      expect(ShortenedUrl.find_by_token(shortened_url.token)).to eq shortened_url
    end
  end

  describe "a new short_url instance" do
    let(:shortened_url) { ShortenedUrl.new }

    it "isn't valid without a full_url" do
      expect(shortened_url).to_not be_valid
      expect(shortened_url.errors[:full_url]).to be_include("can't be blank")
    end

    it "has an invalid url" do
      shortened_url.full_url = 'javascript:alert("Hello World");'
      expect(shortened_url).to_not be_valid
      expect(shortened_url.errors[:full_url]).to be_include("is not a valid url")
    end

    it "doesn't have a token" do
      expect(shortened_url.token).to be_nil
    end
  end
end
