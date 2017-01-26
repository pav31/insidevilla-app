module ApplicationHelper
  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def meta_title_for(title, site)
    return site if title.blank?
    title.include?(site) ? title : "#{title} — #{site}"
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "sortable #{sort_direction}" : "sortable"
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'

    capture do
      link_to({sort: column, direction: direction}, {class: css_class}) do
        concat title
        concat " "
        concat arrow(column)
      end
    end
  end

  def arrow(column)
    params[:sort] ||= 'price_month_low_cents'
    return '' if params[:sort] != column
    arrow = params[:direction] == 'desc' ? 'up' : 'down'
    "<i class='fa fa-caret-#{arrow}'></i>".html_safe
  end

  def check_bool(bool)
    bool ? "√" : "X"
  end

  def system_email?
    email == Settings.system_email_feedback
  end
end
