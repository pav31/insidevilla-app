ActiveAdmin.register Feedback do
  menu priority: 4

  index do
    column :photo do |obj|
      if obj.photo?
        image_tag(obj.photo(:thumb))
      end
    end
    column :author
    column :email
    column :city
    column :occupation
    column :estate_id
    column :approved
    column :favorite

    column t(:approval) do |obj|
      if obj.approved?
        link_to t(:disapprove), disapprove_feedback_admin_feedback_path(obj), method: :put
      else
        link_to t(:approve), approve_feedback_admin_feedback_path(obj), method: :put
      end
    end

    actions
  end

  show do
    attributes_table do
      row :photo do |obj|
        if obj.photo?
          image_tag(obj.photo(:main))
        end
      end
      row :author
      row :email
      row :city
      row :occupation
      row :body
      row :estate_id
      row :approved
      row :favorite
      row :created_at
      row :updated_at
    end

    panel t(:approval) do
      if resource.approved?
        link_to t(:disapprove), disapprove_feedback_admin_feedback_path(resource), method: :put
      else
        link_to t(:approve), approve_feedback_admin_feedback_path(resource), method: :put
      end
    end
  end

  form html: { multipart: true } do |f|
    inputs "Details" do
      input :author
      input :email
      input :city
      input :occupation
      input :body
      input :photo, as: :file, hint: image_tag(object.photo(:thumb))
      input :estate_id, as: :select, collection: Estate.all.collect { |e| [e.title, e.id] }, black: false, require: true
      input :approved
      input :favorite
    end
    f.actions
  end

  member_action :approve_feedback, method: :put do
    resource.approve!
    redirect_to resource_path(resource), notice: t(:feedback_approved)
  end

  member_action :disapprove_feedback, method: :put do
    resource.disapprove!
    redirect_to resource_path(resource), notice: t(:feedback_disapproved)
  end

  permit_params :author, :email, :city, :occupation, :body, :photo, :estate_id, :approved, :favorite
end