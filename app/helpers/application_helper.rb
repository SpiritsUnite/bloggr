module ApplicationHelper
  def full_title(title)
    base = "Bloggr"
    return base if title.empty?
    return "#{title} | #{base}"
  end
end
