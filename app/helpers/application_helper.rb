module ApplicationHelper
  def full_title page_title = ""
    base_title = t "text.Sample_App"
    if page_title.blank?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
