module ApplicationHelper

  def markdown content
    return '' unless content
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    md.render(content).html_safe
  end
end
