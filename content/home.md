---
title: "Parklife: turn a Rack app into a static build"
---
# Parklife

Parklife is a Ruby library to render a Rack app (Rails/Sinatra/etc) to a static build ready to be served by GitHub Pages, Netlify, S3, Vercel, or any other server.

## Getting started

Add Parklife to your application's Gemfile and run `bundle install`.

```ruby
gem 'parklife'
```

Now run [`parklife init`](/cli#init) to generate a `Parkfile` configuration file and build script:

```sh
bundle exec parklife init
```

Include some Rails- or Sinatra-specific settings by passing `--rails` or `--sinatra`, and create a GitHub Actions workflow to generate your Parklife build and push it to GitHub Pages by passing `--github-pages`.

In the generated `Parkfile` [register some routes](/config#routes) for Parklife to fetch:

```ruby
Parklife.application.routes do
  root crawl: true
end
```

Finally, run [`parklife build`](/cli#build) to crawl your app and create a static build.
