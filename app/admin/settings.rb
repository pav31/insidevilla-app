ActiveAdmin.register_page "Settings" do
  title = proc { I18n.t('settings.menu.label') }

  menu label: title, priority: 98

  page_action :update, method: :put

  content title: title  do
    render partial: 'admin/settings/index', locals: { collection: Settings.get_all, path: admin_settings_update_path }
  end

  controller do
    helper :settings

    def update
      settings_params.each_pair do |name, value|
        Settings[name] = value
      end

      flash[:success] = t('settings.success')
      redirect_to :back
    end

    private

    def settings_params
      params.require(:settings).permit(Settings.defaults.keys)
    end
  end

end
