# TinyURL Clone in Ruby on Rails

This is a simple URL shortener built with Ruby on Rails. It allows users to shorten long URLs and track basic visit statistics (IP address, user agent and referer).

## Features

- Generate a short token using `SecureRandom.urlsafe_base64`
- Unique token generation with collision handling
- Redirect to the original URL via the short token
- Track visit statistics for each shortened URL
- Prevent multiple visits on page load with proper Turbo configuration

## Technologies

- Ruby on Rails 7.1.5.1
- PostgreSQL
- Turbo (Hotwire) for interactivity

## Getting Started

### Setup

```bash
git clone git@github.com:SegundoRP/tiny_url_clon.git
cd tiny_url_clon
bundle install
rails db:setup
rails server
```

## Usage

- Create a new shortened URL from the homepage.
- Use the generated short link to access the original URL.
- View statistics for each short URL.

## Security Notes

- Tokens are generated randomly to avoid predictability.
- Token uniqueness is guaranteed with retries in case of collisions.
- All redirects are handled with allow_other_host: true for safety.
