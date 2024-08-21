require 'decant'
require 'kramdown'
require 'kramdown-parser-gfm'
require 'sinatra'

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

get '/' do
  @page = Page.find('home')
  erb :page
end

get '/:slug' do
  @page = Page.find(params[:slug])
  erb :page
end
