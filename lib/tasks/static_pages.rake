desc "Creates static pages"
task create_static_pages: :environment do
  I18n.locale = :en

  def sp_by_title(title, category)
    StaticPage.send(category).with_title_translation(title).first
  end

  StaticPage.import_yml
end
