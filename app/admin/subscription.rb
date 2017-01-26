ActiveAdmin.register Subscription do
  menu priority: 8

  index do
    column :email
    column :active
    actions
  end

  show do
    attributes_table do
      row :email
      row :token
      row :active
    end
  end

  form do |f|
    f.input :email
    f.input :token
    f.input :active
    f.actions
  end

  permit_params :email, :token, :active
end