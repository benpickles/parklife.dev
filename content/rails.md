---
title: Parklife and Rails
---
# Parklife <small>♥︎</small> Rails

A Rails app is a Rack app and as such things Just Work™ but Parklife does provide a few enhancements to make life easier when working with Rails.

Tip: Run [`parklife init --rails`](/cli#init---rails) to tailor the generated `Parkfile` and `bin/static-build` for a Rails app.

Parklife's Rails integration can be enabled in your `Parkfile` with the following:

```ruby
# Initiate Parklife's Rails integration.
require 'parklife/rails'

# Load your Rails application, this gives you full access to the application
# from this file - using models for example.
require_relative 'config/environment'
```

The most visible benefit when using Parklife's Rails integration is that your Rails app's route helpers are available when defining the Parklife routes:

```ruby
Parklife.application.routes do
  # Start from the homepage and crawl all links.
  root crawl: true

  # Some extra paths that aren't discovered by crawling links.
  get feed_path(format: :atom)
  get sitemap_path(format: :xml)

  # A couple more hidden pages.
  get easter_egg_path, crawl: true
end
```
