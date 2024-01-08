module ApplicationHelper
  def label_in_form(form, label)
    form.label "#{label}: ", class: 'col-sm-2 form-label md:tw-text-right'
  end

  def element_in_form(form, field_type, name, label, value, placeholder, custom_div_class = nil, custom_input_class = nil)
    # div안에 label input 넣어서 한 덩어리씩 묶어 만들기
  end
end
