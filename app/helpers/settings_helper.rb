module SettingsHelper
  def settings_field_options(setting_name)
    default_value = Settings.defaults[setting_name]
    value = Settings[setting_name]

    input_opts = if default_value.is_a?(Array)
                   {
                       collection: default_value,
                       selected: value,
                   }
                 else
                   {
                       input_html: {value: value, placeholder: default_value},
                   }
                 end

    {as: :string, label: false}.merge!(input_opts)
  end
end
