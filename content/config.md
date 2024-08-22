---
title: Configure Parklife
---
# Configure Parklife

Parklife is configured via the `Parkfile` file in the root of your project.

> [!TIP]
> Generate a starter `Parkfile` with [`parklife init`](/cli#init).

## Routes

The final build is a collection of _static_ web pages so only `GET` requests can be registered -- via the `#get` method. There's also `#root` which is a shortcut for `get '/'`.

Additionally `crawl: true` can be passed to the route (it's `false` by default) in which case Parklife will discover, follow, and save every link (`<a>` tag) it encounters until there are no new paths to follow from that starting route. It's quite possible that a single `root crawl: true` route will build your whole site.

```ruby
Parklife.application.routes do
  # Starting at the root crawl and save every page encountered.
  root crawl: true

  # Also crawl these pages that aren't linked to from within the main site.
  get '/hidden/pages', crawl: true
end
```

Whilst Parklife follows links (`<a>` tags) within an HTML page it doesn't know about other types of links so these must be added to the routes block:

```ruby
Parklife.application.routes do
  get '/feed.atom'
  get '/sitemap.xml'
end
```

> [!TIP]
> When [Rails integration](/rails) is enabled your Rails app's route helpers are available within the `routes` block.
>
> ```ruby
> Parklife.application.routes do
>   get hidden_pages_path, crawl: true
>   get feed_path(format: :atom)
>   get sitemap_path(format: :xml)
> end
> ```

## Settings

You'll likely encounter settings via the block form:

```ruby
Parklife.application.configure do |config|
  config.build_dir = 'build'
end
```

They're also available on the Parklife application:

```ruby
Parklife.application.config.build_dir = 'build'
```

Here's the full list of settings:

- [`app`](#app)
- [`base`](#base)
- [`build_dir`](#build_dir)
- [`nested_index`](#nested_index)
- [`on_404`](#on_404)

### `app`

If you're using the [Rails integration](/rails) this is already done for you but otherwise you'll need to define the app yourself. See some [framework examples in the Parklife repository](https://github.com/benpickles/parklife/tree/main/examples).

```ruby
Parklife.application.config.app = my_rack_app
```

### `base`

By default Parklife makes requests to your app at a base URL of `http://example.com` and although most of the time you won't have to think about it there are a number of scenarios where your app will need to know its eventual production URL.

Frameworks typically provide URL helpers that -- via Rack -- are compatible with Parklife's `base` setting. This means that, for instance, Rails `*_url` helpers and the Sinatra `url` helper will construct correct URLs based on this value.

> [!NOTE]
> Although your framework's URL helpers will output correct URLs you'll have to take care of manually-written links yourself -- this includes links generated from Markdown.

#### Linking to full URLs

Sometimes you need to construct a _full_ URL and not just an absolute path -- perhaps within a feed or an Open Graph meta tag -- in which case your app will need to know its domain and protocol.

```ruby
Parklife.application.config.base = 'https://parklife.dev'
```

> [!TIP]
> The base URL can be [passed at build-time via the CLI](/cli#build) which will override the setting in your `Parkfile`.

#### Hosting at a subpath (ala GitHub Pages)

When developing your app locally it'll be served from `/` but that's not necessarily the case for the production build -- for instance a GitHub Pages repository project site is hosted at a subpath of the repository's name (unless a custom domain is configured). In this case your app needs to be aware that instead of linking to `/foo` it should link to `/subpath/foo`.

To tell your app that it will be served from a subpath include it when setting the `base`:

```ruby
Parklife.application.config.base = 'https://benpickles.github.io/parklife'
```

You can also pass just the subpath so in the following example the full `base` will be `http://example.com/subpath`:

```ruby
Parklife.application.config.base = '/parklife'
```

> [!TIP]
> Use [`parklife get`](/cli#get) with a custom `--base` to quickly check whether your links are being generated correctly.

### `build_dir`

Where Parklife saves its build files. Defaults to `build`.

```ruby
Parklife.application.config.build_dir = 'my/build/dir'
```

> [!WARNING]
> Parklife destroys and recreates the target `build_dir` before each build.

### `nested_index`

By default Parklife stores all files in an `index.html` file nested in a directory with the same name as the path -- so content from `/my/nested/route` will be stored in the file `/my/nested/route/index.html`. This helps maximise compatibiity with a standard web server by helping to make sure that links within the app work without modification. However, it's possible to turn this off so that `/my/nested/route` is stored in `/my/nested/route.html`.

```ruby
Parklife.application.config.nested_index = false
```

Many modern static hosting providers support mapping the URL `/my/nested/route` to the file `/my/nested/route.html` -- which can sometimes be referred to as friendly/pretty URLs -- and it tends to match the common behaviour of server-side Ruby web frameworks.

Here's a [handy table of how various providers handle trailing slashes and the `.html` file extension](https://www.zachleat.com/web/trailing-slash/#results-table).

> [!NOTE]
> A `Parkfile` generated with [`parklife init --github-pages`](/cli#init---github-pages) comes with `nested_index = false`.

### `on_404`

By default if Parklife encounters a 404 response when fetching a route it will raise an exception and stop the build (the `:error` setting). Possible values are:

- `:error` - raise an exception and stop the build.
- `:warn` - output a message to `stderr`, save the response, and continue processing.
- `:skip` - silently ignore and not save the response, and continue processing.

```ruby
Parklife.application.config.on_404 = :warn
```
