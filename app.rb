require 'decant'
require 'kramdown'
require 'kramdown-parser-gfm'
require 'sinatra'

require_relative 'lib/kramdown_enhancements'

# Define a frontmatter-aware content collection wrapper.
Page = Decant.define(dir: 'content', ext: 'md') do
  frontmatter :title
end

# Configure Sinatra's Markdown rendering (Kramdown will be used because it's
# required above).
set :markdown,
  input: 'GFM',
  smartypants: true,
  views: 'content'

get '/*slug' do
  slug = params[:slug].empty? ? 'home' : params[:slug]
  @page = Page.find(slug)
  @page_title = @page.title
  erb :page
end
