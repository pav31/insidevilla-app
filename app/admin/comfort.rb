ActiveAdmin.register Comfort do
  menu priority: 5

  I18n.available_locales.each do |locale|
    scope locale.to_sym, default: (I18n.locale == locale) do |model|
      model.with_locale(locale)
    end
  end

  index do
    column "icon" do |obj|
      if obj.icon?
        image_tag(obj.icon(:icon))
      end
    end
    if params[:scope]
      column "name_#{params[:scope]}"
    else
      column :name
    end
    actions
  end

  show do
    attributes_table do
      row :icon do |obj|
        if obj.icon?
          image_tag(obj.icon(:icon))
        end
      end
      row :name
      row :category
      row :created_at
      row :updated_at
    end
  end

  form html: { multipart: true } do |f|
    tabs do
      I18n.available_locales.each do |locale|
        tab locale do
          inputs do
            f.input "name_#{locale}"
          end
        end
      end
    end
    inputs "Details" do
      input :icon, as: :file, hint: image_tag(object.icon(:icon))
      input :category, as: :select, collection: Comfort.categories.keys, include_blank: false, required: true
    end
    f.actions
  end

  permit_params :name_en, :name_ru, :category, :icon
end