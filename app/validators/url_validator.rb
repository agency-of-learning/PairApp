class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    uri = URI.parse(value)
    record.errors.add(attribute, 'must include https') if uri.scheme != 'https'
  rescue URI::InvalidURIError
    record.errors.add(attribute, 'must be valid URL')
  end
end
