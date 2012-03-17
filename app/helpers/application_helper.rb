module ApplicationHelper

  def title
    base_title = "Chill And Grill"
    if @title.nil?
      base_title
    else
      "#{base_title} - #{@title}"
    end
  end

  def markdown(text)
  	markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true, :hard_wrap => true)
  	markdown.render(text).html_safe
  end

end
