module ApplicationHelper

  def justification_label(key)
    key ||= "no_justification"
    t("need.justifications.#{key}")
  end

  def progress_class(percentage)
    case
    when percentage < 40 then "progress-danger"
    when percentage == 100 then "progress-success"
    else
      ""
    end
  end
end
