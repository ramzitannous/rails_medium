# frozen_string_literal: true
class User
  include ActiveModel::SecurePassword
  include Mongoid::Document

  has_secure_password

  field :name, type: String
  field :password_digest, type: String
  field :create_date, type: DateTime, default: DateTime.now

  validates_presence_of :name
  validates_uniqueness_of :name


end
