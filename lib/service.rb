# frozen_string_literal: true

# service class
class Service
  attr_reader :name, :other

  def initialize(name)
    @name = name
    @other = 'other value'
  end

  def tell_name
    puts name
  end

end


service = Service.new('Heber')
service.tell_name
