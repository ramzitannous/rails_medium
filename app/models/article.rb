class Article
  include Mongoid::Document

  field :title, type: String
  field :body, type: String
  field :tags, type: Array, default: []
  field :description, type: String
  field :create_date, type: DateTime, default: DateTime.now

  belongs_to :user
  has_many :comments

  validates_presence_of :title, :body, :tags, :description, :user
end
