class Annotation::Link < Annotation
  field :title, type: String
  field :url, type: String

  validates :title, :url, :presence => true

  def format
    "link"
  end
end
