class Organisation
  include Mongoid::Document

  has_many :needs

  field :name, type: String
  field :slug, type: String

  validates :name, :slug, :presence => true
end
