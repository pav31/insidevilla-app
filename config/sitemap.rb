# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://insidevilla.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  # Add '/estates'
  add estates_path, :priority => 0.7, :changefreq => 'daily'

  # Add all estates
  Estate.find_each do |resource|
    add estate_path(resource, locale: :ru), lastmod: resource.updated_at
  end

  # Add Static Pages
  StaticPage.find_each do |resource|
    add static_page_path(resource, locale: :ru), lastmod: resource.updated_at
  end
end
