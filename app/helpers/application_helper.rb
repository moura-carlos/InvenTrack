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
end
