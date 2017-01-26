ActiveAdmin.register_page "Export" do
  menu label: proc { "Export Data" }, priority: 100

  ALLOWED_FOR_EXPORT = %i[static_page]

  content do
    h3 'Export to HTML'
    span link_to "All Data", admin_export_all_html_path, class: "button"
    span link_to "Static Pages", admin_export_static_pages_html_path, class: "button"
    hr
    h3 'Export to YAML'
    span link_to "All Data", admin_export_all_yml_path, class: "button"
    span link_to "Static Pages", admin_export_static_pages_yml_path, class: "button"
  end

  page_action :all_html do
    data = StaticPage.export_html
    send_data data, filename: "all.html", type: "text/html"
  end

  page_action :all_yml do
    require 'zip'

    files ||= []

    ALLOWED_FOR_EXPORT.each do |action|
      data = action.to_s.camelize.constantize.send(:export_yml)
      yml_file = "#{Rails.root}/tmp/#{action.to_s.pluralize}.yml"
      File.open(yml_file, 'w') { |file| file.write(data) }
      files << yml_file
    end

    all_yml = 'all_yml.zip'
    temp_file = Tempfile.new(all_yml)
     
    begin
      Zip::OutputStream.open(temp_file) { |zos| }
     
      Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
          files.each do |file|
            zip.add(file.split('/').last, file)
          end
      end
     
      zip_data = File.read(temp_file.path)
    ensure
      files.each { |file| File.delete(file) if File.exist?(file) }
      temp_file.close
      temp_file.unlink
      send_data zip_data, :type => 'application/zip', :filename => all_yml
    end
  end

  ALLOWED_FOR_EXPORT.each do |action|
    page_action "#{action.to_s.pluralize}_html" do
      send_data action.to_s.camelize.constantize.send(:export_html), filename: "#{action.to_s.pluralize}.html", type: "text/html"
    end
    page_action "#{action}s_yml" do
      send_data action.to_s.camelize.constantize.send(:export_yml), filename: "#{action.to_s.pluralize}.yml", type: "text/yaml"
    end
  end
end

 
