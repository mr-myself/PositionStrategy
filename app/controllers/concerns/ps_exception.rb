module PsException
  class ValidationError < StandardError
    attr_accessor :messages

    def initialize(errors)
      self.messages = errors.map{|key, value| value}.join
    end
  end
end
