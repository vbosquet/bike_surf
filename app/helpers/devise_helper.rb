module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.values.map { |msg| content_tag(:li, (msg.first if msg.any?)) }.join
    html = <<-HTML
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <button type="button" class="close" data-dismiss="alert">
        <span aria-hidden="true">&times;</span>
      </button>
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end
