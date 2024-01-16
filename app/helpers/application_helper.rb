module ApplicationHelper
  def label_in_form(form, label)
    form.label "#{label.chars.join(' ')}: ", class: 'col-sm-2 form-label md:tw-text-justify tw-mr-2', style: "text-align-last: justify;"
  end

  def element_in_form(form, name, label, custom_div_class = nil, custom_input_class = nil)
    # div 안에 label input 넣어서 한 덩어리씩 묶어 만들기

    tag.div(class: "#{ custom_div_class.nil? ? 'tw-flex mb-3 sm:tw-max-w-md' : custom_div_class}") do
      form.label("#{label.chars.join(' ')}: ", class: 'tw-w-28 tw-mr-2 form-label md:tw-text-justify', style: "text-align-last: justify;") +
        yield(form, name, "form-control form-control-sm")
      # field_type.call(name, class: "col form-control form-control-sm", value: value, placeholder: placeholder )
    end

    # tag.div(class: "#{ custom_div_class.nil? ? 'row g-2 mb-3 sm:tw-max-w-md' : custom_div_class}") do
    #   form.label("#{label.chars.join(' ')}: ", class: 'col-sm-3 form-label md:tw-text-justify tw-mr-2', style: "text-align-last: justify;") +
    #     yield(form, name, "col form-control form-control-sm")
    # end
  end


  def table_from_hash

  end
end
