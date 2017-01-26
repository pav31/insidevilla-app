module ExportData
  extend ActiveSupport::Concern
  ALLOWED_MODELS = %w[StaticPage]
  ENUMS = %i[category]

  included do
    extend ActionView::Helpers::TagHelper
  end

  class_methods do
    def export_html
      title, content = [:title, :content]
      content_tag(:h2, name).to_str + all.map do |t|
        content_tag(:h3, t.send(title)) + t.send(content)
      end.join("<br>")
    end

    def export_yml
      return unless name.in? ALLOWED_MODELS
      exclude_fields = %w(id created_at updated_at)
      all.map { |t| t.attributes.except(*exclude_fields) }.to_yaml
    end

    def import_yml
      table = table_name
      file_name = Rails.root.join('lib', 'data', "#{table}.yml")
      return unless name.in? ALLOWED_MODELS
      raise RuntimeError, "File '#{file_name}' does not exist" unless file_name.exist?
      transaction do
        destroy_all
        YAML.load_file(file_name).map { |attrs| create(attrs) }
      end
    end
  end
end
