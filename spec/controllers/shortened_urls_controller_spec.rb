require 'rails_helper'

RSpec.describe ShortenedUrlsController, type: :controller do
  describe 'POST #create' do
    let(:valid_params) { { shortened_url: { full_url: 'https://example.com' } } }
    let(:invalid_params) { { shortened_url: { full_url: 'test' } } }

    context 'with valid params' do
      it 'creates a new ShortenedUrl' do
        expect do
          post :create, params: valid_params
        end.to change(ShortenedUrl, :count).by(1)
      end

      it 'responds with a redirect status' do
        post :create, params: valid_params
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with invalid params' do
      it 'does not create a new ShortenedUrl' do
        expect do
          post :create, params: invalid_params
        end.not_to change(ShortenedUrl, :count)
      end

      it  'responds with a bad request status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'GET #redirect' do
    let(:shortened_url) { create(:shortened_url) }

    it 'redirects to the full URL' do
      get :redirect, params: { token: shortened_url.token }
      expect(response).to redirect_to(shortened_url.full_url)
    end

    it 'creates a visit record' do
      expect do
        get :redirect, params: { token: shortened_url.token }
      end.to change(Visit, :count).by(1)
    end
  end
end
