class Organisation
  include Mongoid::Document

  has_many :needs

  field :name, type: String
  field :slug, type: String

  validates :name, :slug, :presence => true
  validates :slug, :uniqueness => { :case_sensitive => false }

  scope :in_name_order, order_by([:name, :asc])
end
