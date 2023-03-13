module ApplicationHelper
  def flash_class(type)
    case type
    when 'notice' then 'alert-primary'
    when 'success' then 'alert-success'
    when 'error' then 'alert-danger'
    when 'alert' then 'alert-warning'
    else 'alert-secondary'
    end
  end

  def inventrack_logo
    if current_user
      link_to "InvenTrack", items_path, class: "navbar-brand"
    else
      link_to "InvenTrack", root_path, class: "navbar-brand"
    end
  end
end
