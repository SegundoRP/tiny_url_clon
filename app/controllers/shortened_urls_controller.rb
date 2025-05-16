class ShortenedUrlsController < ApplicationController
  before_action :set_shortened_url, only: [:redirect, :info]

  def new
    @shortened_url = ShortenedUrl.new
  end

  def create
    @shortened_url = ShortenedUrl.new(short_url_params)

    if @shortened_url.save
      redirect_to shortened_url_info_path(@shortened_url.token)
    else
      render :new, status: :bad_request
    end
  end

  def redirect
    @shortened_url.visits.create!(
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      referer: request.referer
    )

    redirect_to @shortened_url.full_url, allow_other_host: true
  end

  def info
    @visits = @shortened_url.visits.order(created_at: :desc)
  end

  private

  def set_shortened_url
    @shortened_url = ShortenedUrl.find_by(token: params[:token])

    unless @shortened_url
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
  end

  def short_url_params
    params.require(:shortened_url).permit(:full_url)
  end
end
