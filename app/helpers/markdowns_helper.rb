module MarkdownsHelper
  def markdown(content)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, fenced_code_blocks: true, strikethrough: true)
    markdown.render(content).html_safe
  end
end
