module ApplicationHelper

  def full_title(title)
    base = "Bloggr"
    return base if title.empty?
    return "#{title} | #{base}"
  end

  def nav_link(name, path, options = nil)
    render "layouts/nav_link", name: name, path: path, options: options
  end
end
