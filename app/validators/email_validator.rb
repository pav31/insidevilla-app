class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless self.class.check_email(value)
      record.errors[attribute] << (options[:message] || I18n.t('errors.messages.invalid', default: 'is not valid'))
    end
  end

  def self.check_email(email)
    email =~ /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/i && (6..264).include?(email.size)
  end
end
