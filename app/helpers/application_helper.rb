module ApplicationHelper
	def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    # => used to build the html and css to dosplay the form element and any associated errors
    content_tag :div, capture(&block), class: css_class
  end

  def markdown(text)
       options = {
           hard_wrap: true,
           filter_html: true,
           no_intra_emphasis: true,
           fenced_code_blocks: true,
           tables: true,
           lax_html_blocks: true,
           strikethrough: true,
       }

       extensions = {
       	autolink: true,
       	superscript: true,
       	disable_indented_code_blocks: true
       }
       renderer = Redcarpet::Render::HTML.new(options)
       markdown = Redcarpet::Markdown.new(renderer, extensions)

       markdown.render(text).html_safe
   end
end
