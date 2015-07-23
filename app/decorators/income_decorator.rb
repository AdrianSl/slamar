class IncomeDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  delegate_all
  decorates_association :driver

  def value
    number_with_precision object.value, precision: 2
  end

  def midday_value
    number_with_precision object.midday_value, precision: 2
  end

  def edit_link
    unless object.value.nil? && object.midday_value.nil? && income.driver.nil?
      h.content_tag(:a, h.icon('pencil'), id:"#{income.id}_link_disabled", onclick: "edit(#{income.id})") 
    end
  end

  def dashboard_midday_value
    h.fields_for "incomes[]", income do |f|
      if object.midday_value.nil?
        f.text_field :midday_value, class: "form-control input-sm text-right", placeholder: 'Midday value'
      else
        h.content_tag(:fieldset, id: "#{object.id}_midday_value_disabled", disabled: true) do
          f.text_field :midday_value, class: "form-control input-sm text-right", value: object.midday_value
        end
      end
    end
  end

  def dashboard_value
    h.fields_for "incomes[]", income do |f|
      if object.value.nil?
        f.text_field :value, class: "form-control input-sm text-right", placeholder: 'Value'
      else
        h.content_tag(:fieldset, id: "#{object.id}_value_disabled", disabled: true) do
          f.text_field :value, class: "form-control input-sm text-right", value: object.value
        end
      end
    end
  end

  def dashboard_driver(collection)
    h.fields_for "incomes[]", income do |f|
      if object.driver.nil?
        f.select(:driver_id, h.options_for_select(collection), {prompt: "Select driver!"}, { class: "form-control input-sm"})
      else
        h.content_tag(:fieldset, id: "#{object.id}_driver_disabled", disabled: true) do
          f.select(:driver_id, h.options_for_select(collection, object.driver_id), {}, { class: "form-control input-sm"} )
        end
      end
    end
  end
end
