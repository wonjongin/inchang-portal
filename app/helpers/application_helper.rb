module ApplicationHelper
  def label_in_form(form, label)
    form.label "#{label}: ", class: 'col-sm-2 form-label tw-text-right'
  end
end
