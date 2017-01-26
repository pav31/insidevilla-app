ActiveAdmin.register Booking do
  menu priority: 3

  preserve_default_filters!
  filter :status, as: :select, collection: -> { Booking.statuses.map { |key, _| [I18n.t("booking_statuses.#{key}"), key] } }

  index do
    column :estate_id
    column :move_in_at
    column :move_out_at
    column :status do |obj|
      t("booking_statuses.#{obj.status}")
    end
    column :name
    column :email
    column :phone_number
    column :adults
    column :kids
    column :car_rental
    column :airport_transfer
    column :escort_service

    actions
  end

  show do
    attributes_table do
      row :estate_id
      row :move_in_at
      row :move_out_at
      row :name
      row :email
      row :phone_number
      row :adults
      row :kids
      row :comment
      row :car_rental
      row :airport_transfer
      row :escort_service
      row :status do |obj|
        t("booking_statuses.#{obj.status}")
      end
    end

    panel t(:change_status) do
      (Booking.statuses - [resource.status]).each do |status|
        div link_to t("change_booking_statuses.#{status}"), { action: "#{status}_booking", id: resource.id }, method: :put
      end
    end
  end

  form html: { multipart: true } do |f|
    inputs "Details" do
      input :move_in_at
      input :move_out_at
      input :name
      input :email
      input :phone_number
      input :adults
      input :kids
      input :status, as: :select, collection: Booking.statuses.map { |key, _| [I18n.t("booking_statuses.#{key}"), key] }, black: false, require: true
      input :estate_id, as: :select, collection: Estate.all.collect { |e| [e.title, e.id] }, black: false, require: true
      input :comment
    end

    inputs t(:additional) do
      input :car_rental
      input :airport_transfer
      input :escort_service
    end

    f.actions
  end

  member_action :approved_booking, method: :put do
    msg = resource.approved! ? { notice: t(:booking_approved) } : { alert: resource.errors.full_messages.to_sentence }
    redirect_to resource_path(resource), msg
  end

  member_action :pending_booking, method: :put do
    msg = resource.pending! ? { notice: t(:booking_pending) } : { alert: resource.errors.full_messages.to_sentence }
    redirect_to resource_path(resource), msg
  end

  member_action :completed_booking, method: :put do
    msg = resource.completed! ? { notice: t(:booking_completed) } : { alert: resource.errors.full_messages.to_sentence }
    redirect_to resource_path(resource), msg
  end

  member_action :canceled_booking, method: :put do
    msg = resource.canceled! ? { notice: t(:booking_canceled) } : { alert: resource.errors.full_messages.to_sentence }
    redirect_to resource_path(resource), msg
  end

  member_action :unavailable_booking, method: :put do
    msg = resource.unavailable! ? { notice: t(:booking_unavailable) } : { alert: resource.errors.full_messages.to_sentence }
    redirect_to resource_path(resource), msg
  end

  permit_params :move_in_at, :move_out_at, :name, :email, :phone_number, :adults, :kids, :comment, :car_rental, :airport_transfer, :escort_service, :status, :estate_id
end