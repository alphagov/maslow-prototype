class Annotation::Legislation < Annotation
  field :title, type: String
  field :section, type: String

  validates :title, :presence => true

  def format
    "legislation"
  end
end
