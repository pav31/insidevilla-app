ActiveAdmin.register Slider do
  menu priority: 6

  I18n.available_locales.each do |locale|
    scope locale.to_sym, default: (I18n.locale == locale) do |model|
      model.with_locale(locale)
    end
  end

  index do
    column "image" do |obj|
      if obj.image?
        image_tag(obj.image(:thumb))
      end
    end
    if params[:scope]
      column "title_#{params[:scope]}"
      column "text_#{params[:scope]}"
    else
      column :title
      column :text
    end
    column :priority
    column :active
    actions
  end

  show do
    attributes_table do
      row :image do |obj|
        if obj.image?
          image_tag(obj.image(:preview))
        end
      end
      row :title
      row :text
      row :priority
      row :active
      row :created_at
      row :updated_at
    end
  end

  form html: { multipart: true } do |f|
    tabs do
      I18n.available_locales.each do |locale|
        tab locale do
          inputs do
            f.input "title_#{locale}"
            f.input "text_#{locale}"
          end
        end
      end
    end

    f.inputs t(:general_data) do
      input :image, as: :file
      input :priority
      input :active
    end
    f.actions
  end

  permit_params :title_en, :title_ru, :text_en, :text_ru, :image, :priority, :active
end