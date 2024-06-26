ActionView::Helpers::FormBuilder.class_eval do
  def error_message(field)
    errors = object.errors[field]

    return unless errors.present?

    @template.content_tag(:small, errors.first, class: 'form-text text-danger')
  end
end
