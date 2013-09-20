class Annotation::Priority < Annotation
  field :popular,        type: Integer
  field :risk,           type: Integer
  field :problematic,    type: Integer
  field :functional_gap, type: Integer
  field :overall,        type: Integer

  validates :popular, :risk, :problematic, :functional_gap,
            :numericality => {
              :only_integer => true,
              :greater_than_or_equal_to => 0,
              :less_than_or_equal_to => 4,
              :allow_blank => true
            }

  def can_calculate?
    [ popular, risk, problematic, functional_gap ].select(&:present?).size == 4
  end

  def overall
    return unless can_calculate?
    (popular + risk + problematic + functional_gap).to_f
  end

  def format
    "priority"
  end
end
