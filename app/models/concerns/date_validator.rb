class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value = record.send("#{attribute}_before_type_cast")
    begin
      Date.parse value if value.present?
    rescue ArgumentError
      record.errors[attribute] << I18n.t('errors.messages.invalid')
    end
  end
end
