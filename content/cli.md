---
title: The Parklife CLI
---
# The Parklife CLI

Alongside `parklife build` there are a few other commands that can be quite handy. Here's the full list:

- [`parklife build`](#build)
- [`parklife config`](#config)
- [`parklife get PATH`](#get)
- [`parklife help [COMMAND]`](#help)
- [`parklife init`](#init)
- [`parklife routes`](#routes)
- [`parklife version`](#version)

## `build`

```sh
parklife build
```

Crawl your app to create a static build.

You can also pass a custom `--base` to override the [`config.base`](/config#base) configured in your `Parkfile`:

```sh
parklife build --base https://parklife.dev
```

## `config`

```sh
parklife config
```

Output the full Parklife config settings.

## `get`

`parklife get PATH` can be really useful, it's basically "view source" for your app and outputs the provided path's HTML to the terminal. You can also pass a custom `--base` to override the [`config.base`](/config#base) configured in your `Parkfile`.

> [!TIP]
> Quickly check that the correct URLs are generated when using a `--base` subpath:
>
> ```sh
> parklife get / --base /foo | grep /link/to/check
> ```

> [!TIP]
> Get syntax-highlighting in the terminal by piping the output to [`bat`](https://github.com/sharkdp/bat):
>
> ```sh
> parklife get /my/page | bat -lhtml
> ```

## `help`

```sh
parklife help
```

Parklife's CLI is built with [Thor](http://whatisthor.com) so you get the usual `parklife help [COMMAND]` output.

## `init`

Run `parklife init` to create a starter `Parkfile` configuration file and a `bin/static-build` script used to generate the full production static build.

> [!NOTE]
> `parklife init` can be safely run in an existing project and will ask before overwriting files (because it's built with [Thor](http://whatisthor.com)).

There are also some flags to tailor the generated files:

### `init --github-pages`

Generate an additional full GitHub Actions workflow at `.github/workflows/parklife.yml` that will build and deploy your site to GitHub Pages whenever you push to the main branch.

### `init --rails`

Add [Rails integration](/rails) to the `Parkfile` and `bin/static-build`.

### `init --sinatra`

Add a little ditty to the `Parkfile` how to integrate with your Sinatra app.

## `routes`

List all [defined routes](/config#routes) and whether the route has crawling enabled.

Note that this lists _Parklife's_ routes not your app's routes. It's likely that you've configured Parklife to crawl from the root which should encounter the vast majority of your site's pages but will not list them here.

Example:

```sh
$ parklife routes
/             crawl=true
/feed.atom
/sitemap.xml
/easter_egg   crawl=true
/404.html
```

## `version`

What version of Parklife is this?
