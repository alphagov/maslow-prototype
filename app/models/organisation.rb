class Organisation
  include Mongoid::Document

  field :name, type: String
  field :slug, type: String

  validates :name, :slug, :presence => true
  validates :slug, :uniqueness => { :case_sensitive => false }

  scope :in_name_order, order_by([:name, :asc])

  def needs
    Need.where(:organisation_ids => id)
  end
end
