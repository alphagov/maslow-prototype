class Annotation
  include Mongoid::Document

  embedded_in :need

  def format
    "annotation"
  end
end
