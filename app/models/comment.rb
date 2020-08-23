# frozen_string_literal: true

class Comment
  include Mongoid::Document

  field :content, type: String
  field :create_date, type: DateTime, default: DateTime.now

  belongs_to :article
  belongs_to :user
end
