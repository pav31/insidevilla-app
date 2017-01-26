ActiveAdmin.register Estate do
  menu priority: 2

  PARAMS = %i[
    admin_price
    admin_price_day_low
    admin_price_day_high
    admin_price_day_pick
    admin_price_week_low
    admin_price_week_high
    admin_price_week_pick
    admin_price_month_low
    admin_price_month_high
    admin_price_month_pick
    price
    price_day_low
    price_day_high
    price_day_pick
    price_week_low
    price_week_high
    price_week_pick
    price_month_low
    price_month_high
    price_month_pick

    commission_short_term commission_long_term
    owner_name owner_phone owner_email owner_comment we_manage
    title_en title_ru address description_en description_ru price featured available draft estate_type tenure_type
    estate_class area_size slider main_image bedrooms bathrooms place region sea_distance lat long airport_distance
    closest_beach toilets double_beds single_beds cleaning_period living_area photo_link comment
  ]

  I18n.available_locales.each do |locale|
    scope locale.to_sym, default: (I18n.locale == locale) do |model|
      model.with_locale(locale)
    end
  end

  # TODO: filter prices w/o cent
  preserve_default_filters!
  filter :tenure_type, as: :select, collection: -> { Estate.tenure_types.map { |key, _| [I18n.t("tenure_types.#{key}"), key] } }
  filter :estate_type, as: :select, collection: -> { Estate.estate_types.map { |key, _| [I18n.t("estate_types.#{key}"), key] } }
  filter :estate_class, as: :select, collection: -> { Estate.estate_classes.map { |key, _| [I18n.t("estate_classes.#{key}"), key] } }
  filter :place, as: :select, collection: -> { Estate.places.map { |key, _| [I18n.t("estate_regions.#{key}"), key] } }
  filter :region, as: :select, collection: -> { Estate.regions.map { |key, _| [I18n.t("estate_regions.#{key}"), key] } }
  filter :cleaning_period, as: :select, collection: -> { Estate.cleaning_periods.map { |key, _| [I18n.t("cleaning_periods.#{key}"), key] } }
  filter :comforts, as: :check_boxes
  filter :admin_price
  filter :we_manage
  remove_filter :created_at, :updated_at, :estate_comforts,  :images, :slider, :commission_short_term, :commission_long_term, :lat, :long, :latitude, :longitude
  remove_filter :main_image_file_name, :main_image_content_type, :main_image_file_size, :main_image_updated_at
  remove_filter :slider_file_name, :slider_content_type, :slider_file_size, :slider_updated_at

  index do
    column :id
    column "Main Image" do |obj|
      link_to image_tag(obj.main_image(:thumb)), admin_estate_path(obj)
    end
    column do |obj|
      link_to (params[:scope] ? obj.send("title_#{params[:scope]}") : obj.title), admin_estate_path(obj)
    end
    column :estate_class do |obj|
      I18n.t("estate_classes.#{obj.estate_class}")
    end
    # Uncomment to show list of comforts
    # column :comforts do |obj|
    #   obj.comforts.map{ |c| c.name }.join(', ')
    # end
    column :place do |obj|
      I18n.t("places.#{obj.place}")
    end
    column :region do |obj|
      I18n.t("estate_regions.#{obj.region}")
    end
    column :estate_type do |obj|
      I18n.t("estate_types.#{obj.estate_type}")
    end
    column :tenure_type do |obj|
      I18n.t("tenure_types.#{obj.tenure_type}")
    end
    column :we_manage
    actions
  end

  show do
    attributes_table do
      row :id
      row :title do
        h2 estate.title
      end
      row :main_image do |obj|
        image_tag(obj.main_image(:thumb))
      end
      row :slider do |obj|
        link_to image_tag(obj.slider(:thumb)), obj.slider.url
      end
      row :address
      row :tenure_type do |obj|
        I18n.t("tenure_types.#{obj.tenure_type}")
      end
      row :place do |obj|
        I18n.t("places.#{obj.place}")
      end
      row :region do |obj|
        I18n.t("estate_regions.#{obj.region}")
      end
      row :description
      row :estate_type do |obj|
        I18n.t("estate_types.#{obj.estate_type}")
      end
      row :estate_class do |obj|
        I18n.t("estate_classes.#{obj.estate_class}")
      end
      row :sea_distance
      row :airport_distance
      row :closest_beach
      row :bedrooms
      row :bathrooms
      row :toilets
      row :double_beds
      row :single_beds
      row :area_size
      row :living_area
      row :cleaning_period do |obj|
        if period = obj.cleaning_period
          t("cleaning_periods.#{period}")
        else
          nil
        end
      end
      row :we_manage
      row :draft
      row :featured
      row :available
    end

    panel t(:prices), class: 'price-panel' do
      div(class: 'label') { h6 t(:period) }
      div(class: 'price') { h6 t(:customer_price) }
      div(class: 'price') { h6 t(:admin_price) }
      hr
      div(class: 'label') { t('activerecord.attributes.estate.price') }
      div(class: 'price') { humanized_money_with_symbol(estate.price) }
      div(class: 'price') { humanized_money_with_symbol(estate.admin_price) }
      hr
      div(class: 'label') { t('activerecord.attributes.estate.price_day_low') }
      div(class: 'price') { humanized_money_with_symbol(estate.price_day_low) }
      div(class: 'price') { humanized_money_with_symbol(estate.admin_price_day_low) }
      hr
      div(class: 'label') { t('activerecord.attributes.estate.price_day_high') }
      div(class: 'price') { humanized_money_with_symbol(estate.price_day_high) }
      div(class: 'price') { humanized_money_with_symbol(estate.admin_price_day_high) }
      hr
      div(class: 'label') { t('activerecord.attributes.estate.price_day_pick') }
      div(class: 'price') { humanized_money_with_symbol(estate.price_day_pick) }
      div(class: 'price') { humanized_money_with_symbol(estate.admin_price_day_pick) }
      hr
      div(class: 'label') { t('activerecord.attributes.estate.price_week_low') }
      div(class: 'price') { humanized_money_with_symbol(estate.price_week_low) }
      div(class: 'price') { humanized_money_with_symbol(estate.admin_price_week_low) }
      hr
      div(class: 'label') { t('activerecord.attributes.estate.price_week_high') }
      div(class: 'price') { humanized_money_with_symbol(estate.price_week_high) }
      div(class: 'price') { humanized_money_with_symbol(estate.admin_price_week_high) }
      hr
      div(class: 'label') { t('activerecord.attributes.estate.price_week_pick') }
      div(class: 'price') { humanized_money_with_symbol(estate.price_week_pick) }
      div(class: 'price') { humanized_money_with_symbol(estate.admin_price_week_pick) }
      hr
      div(class: 'label') { t('activerecord.attributes.estate.price_month_low') }
      div(class: 'price') { humanized_money_with_symbol(estate.price_month_low) }
      div(class: 'price') { humanized_money_with_symbol(estate.admin_price_month_low) }
      hr
      div(class: 'label') { t('activerecord.attributes.estate.price_month_high') }
      div(class: 'price') { humanized_money_with_symbol(estate.price_month_high) }
      div(class: 'price') { humanized_money_with_symbol(estate.admin_price_month_high) }
      hr
      div(class: 'label') { t('activerecord.attributes.estate.price_month_pick') }
      div(class: 'price') { humanized_money_with_symbol(estate.price_month_pick) }
      div(class: 'price') { humanized_money_with_symbol(estate.admin_price_month_pick) }
      div(class: 'clearfix')
    end

    panel t(:commission) do
      attributes_table_for estate do
        row :commission_long_term, class: 'half-size'
        row :commission_short_term, class: 'half-size'
      end
    end

    panel t(:owner_info) do
      attributes_table_for estate do
        row :owner_name, class: 'half-size'
        row :owner_phone, class: 'half-size'
        row :owner_email, class: 'half-size'
        row :owner_comment
      end
    end

    panel t(:additional_info) do
      attributes_table_for estate do
        row :photo_link
        row :comment
      end
    end

    panel t(:coordinates) do
      attributes_table_for estate do
        row :latitude, class: 'half-size'
        row :longitude, class: 'half-size'
        row :lat, class: 'half-size'
        row :long, class: 'half-size'
      end
    end


    panel "Delete Comforts", class: 'clearfix' do
      ul do
        estate.comforts.each do |comfort|
          li do
            link_to image_tag(comfort.icon(:icon), alt: comfort.name), destroy_comfort_admin_estate_path(estate, comfort_id: comfort.id), method: :put
          end
        end
        text_node "&nbsp".html_safe
      end
    end

    panel "Add Comforts" do
      ul do
        Comfort.find_each do |comfort|
          unless estate.comforts.include? comfort
            li do
              link_to image_tag(comfort.icon(:icon), alt: comfort.name), add_comfort_admin_estate_path(estate, comfort: comfort), method: :put
            end
          end
        end
        text_node "&nbsp".html_safe
      end
    end

    panel "Delete Images" do
      ul do
        estate.images.each do |image|
          li do
            link_to image_tag(image.attachment(:thumb), alt: image.name), destroy_image_admin_estate_path(estate, image_id: image.id), method: :put, data: { confirm: t(:are_you_sure) }
          end
        end
        text_node "&nbsp".html_safe
      end
    end
  end

  form html: { multipart: true }, class: 'as_inline_form' do |f|
    tabs do
      I18n.available_locales.each do |locale|
        tab locale do
          inputs do
            f.input "title_#{locale}"
            f.input "description_#{locale}", as: :ckeditor
          end
        end
      end
    end

    f.inputs t(:general_data) do
      input :slider, as: :file, hint: image_tag(object.slider(:thumb)), required: :true
      input :main_image, as: :file, hint: image_tag(object.main_image(:thumb))
      input :address

      input :place, as: :select, collection: Estate.places.map { |key, _| [I18n.t("places.#{key}"), key] }, include_blank: false, required: true
      input :region, as: :select, collection: Estate.regions.map { |key, _| [I18n.t("estate_regions.#{key}"), key] }, include_blank: false, required: true
      input :estate_type, as: :select, collection: Estate.estate_types.map { |key, _| [I18n.t("estate_types.#{key}"), key] }, include_blank: false, required: true
      input :tenure_type, as: :select, collection: Estate.tenure_types.map { |key, _| [I18n.t("tenure_types.#{key}"), key] }, include_blank: false, required: true
      input :estate_class, as: :select, collection: Estate.estate_classes.map { |key, _| [I18n.t("estate_classes.#{key}"), key] }, include_blank: false, required: true
      input :cleaning_period, as: :select, collection: Estate.cleaning_periods.map { |key, _| [I18n.t("cleaning_periods.#{key}"), key] }

      input :area_size
      input :living_area
      input :bedrooms
      input :bathrooms
      input :toilets
      input :double_beds
      input :single_beds
      input :sea_distance
      input :airport_distance
      input :closest_beach
      input :draft
      input :featured
      input :available
      input :we_manage

      inputs t(:prices), class: 'inline-input' do
        input :price
        input :admin_price
        input :price_day_low
        input :admin_price_day_low
        input :price_day_high
        input :admin_price_day_high
        input :price_day_pick
        input :admin_price_day_pick
        input :price_week_low
        input :admin_price_week_low
        input :price_week_high
        input :admin_price_week_high
        input :price_week_pick
        input :admin_price_week_pick
        input :price_month_low
        input :admin_price_month_low
        input :price_month_high
        input :admin_price_month_high
        input :price_month_pick
        input :admin_price_month_pick
      end

      inputs t(:commission) do
        input :commission_long_term, require: false
        input :commission_short_term, require: false
      end

      inputs t(:owner_info) do
        input :owner_name
        input :owner_phone
        input :owner_email
        input :owner_comment
      end

      inputs t(:additional_info) do
        input :photo_link
        input :comment
      end

      inputs t(:coordinates) do
        input :lat
        input :long
      end
      inputs t(:comforts), class: 'inline-comforts' do
        input :comforts, as: :check_boxes, checked: estate.comfort_ids, label: false
      end
    end

    f.actions
  end

  member_action :add_comfort, method: :put do
    resource.add_comfort(params[:comfort]) unless resource.comfort_ids.include? params[:comfort]
    redirect_to resource_path(resource), notice: t(:comfort_added)
  end

  member_action :destroy_comfort, method: :put do
    resource.comforts.destroy(params[:comfort_id])
    redirect_to resource_path(resource), notice: t(:comfort_destroyed)
  end

  member_action :destroy_image, method: :put do
    resource.images.destroy(params[:image_id])
    redirect_to resource_path(resource), notice: t(:image_destroyed)
  end

  permit_params *PARAMS + [ comfort_ids: [], images_attributes: [:attachment, :name, :_destroy] ]
end
