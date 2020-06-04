class Form::EmailCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  EMAIL_NUM = 5
  attr_accessor :collection

  def initialize(attributes = [])
    if attributes.present?
      self.collection = attributes.map do |value|
        Email.new(user_id:value['user_id'], email: value['email'] )
      end
    else
      self.collection = EMAIL_NUM.times.map{ Email.new }
    end
  end

  def persisted?
    false
  end

  def save
    is_success = true
    ActiveRecord::Base.transaction do
      collection.each do |result|
        is_success = false unless result.save
      end
      raise ActiveRecord::RecordInvalid unless is_success
    end
    rescue
      p 'エラー'
    ensure
      return is_success
  end
end
