# frozen_string_literal: true

module Mongoid
  module Document
    def as_json(options = {})
      attrs = super(options)
      new_attrs = {}
      new_attrs['id'] = attrs['_id']['$oid'].to_s
      attrs.delete('_id')
      new_attrs.merge(attrs)
    end
  end
end
