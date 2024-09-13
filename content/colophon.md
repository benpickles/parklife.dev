---
title: Colophon
---
# Colophon

This site is a [Parklife](https://github.com/benpickles/parklife)/[Sinatra](https://sinatrarb.com) static site hosted on GitHub Pages, [it's open source](https://github.com/benpickles/parklife.dev) and contributions are welcome and appreciated.

I chose Sinatra because it provides an awful lot of useful functionality out-of-the-box and its concise syntax makes it incredibly easy to make a fully-working website -- the whole app is [basically one file with very few lines of code](https://github.com/benpickles/parklife.dev/blob/main/app.rb).

I wrote [Decant](https://github.com/benpickles/decant) because it's what was missing from my Parklife party -- easy frontmatter-aware access to a directory of content files (Markdown in this case). Here's how it's used in this site:

```ruby
# Define a model-like class to wrap the content.
Page = Decant.define(dir: 'content', ext: 'md') do
  # Declare a frontmatter convenience reader.
  frontmatter :title
end

# Now find the page and work with it.
page = Page.find('colophon')
page.title   # => "Colophon"
page.content # => "---\ntitle: Colophon\n---# Colophon\n"...
```

Markdown is handled by [Kramdown](https://kramdown.gettalong.org) with syntax-highlighting by [Rouge](https://rouge.jneen.net) styled by [Pygments](https://github.com/richleland/pygments-css/blob/master/default.css). I added support for [GitHub-style alert callouts](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts) by [extending Kramdown](https://github.com/benpickles/parklife.dev/blob/main/lib/kramdown_enhancements.rb).

Here are the different alert types (for development/debugging), the icons are from [Heroicons](https://heroicons.com):

> [!NOTE]
> A note.

> [!TIP]
> A tip.

> [!IMPORTANT]
> They can have...
>
> Many paragraphs.

> [!WARNING]
> And contain:
>
> - any
> - other
> - Markdown

> [!CAUTION]
> Including syntax-highlighted code blocks:
>
> ```ruby
> if I.should(:stay)
>   I.ll(:only).be in("your way")
> end
> ```
