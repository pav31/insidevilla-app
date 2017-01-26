ActiveAdmin.register StaticPage do
  menu priority: 7

  I18n.available_locales.each do |locale|
    scope locale.to_sym, default: (I18n.locale == locale) do |model|
      model.with_locale(locale)
    end
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    column :image do |obj|
      if obj.image?
        image_tag(obj.image(:thumb))
      end
    end
    if params[:scope]
      column "title_#{params[:scope]}"
    else
      column :title
    end
    column :category do |c|
      I18n.t("static_pages.#{c.category}")
    end
    actions
  end

  show do
    attributes_table do
      row :image do |obj|
        if obj.image?
          image_tag(obj.image(:full_size))
        end
      end
      row :category do |c|
        I18n.t("static_pages.#{c.category}")
      end
      row :title
      row :content
      row :slug
      row :position
      row :meta_title
      row :keywords
      row :description
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    tabs do
      I18n.available_locales.each do |locale|
        tab locale do
          inputs do
            # panel "z" do
            f.input "title_#{locale}"
            f.input "content_#{locale}", as: :ckeditor
          end
        end
      end
    end
    inputs "Details" do
      input :category, as: :select, collection: I18n.t(:static_pages).to_a.map(&:reverse), include_blank: false, required: true
      input :slug
      input :position, required: true
      input :image, as: :file
    end

    inputs "Meta" do
      input :meta_title
      input :keywords
      input :description
    end

    f.actions
  end

  permit_params :category, :title_en, :content_en, :title_ru, :content_ru, :slug, :position, :image, :meta_title, :keywords, :description
end
