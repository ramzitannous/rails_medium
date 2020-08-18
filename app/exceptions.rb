# frozen_string_literal: true

module AppExceptions
  class UnAuthorized < RuntimeError
    attr_reader :msg

    def initialize(message = nil)
      @msg = message || 'user is UnAuthorized'
    end
  end
end
