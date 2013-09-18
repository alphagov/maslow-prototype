class Need
  include Mongoid::Document

  field :reference, type: Integer

  field :story_role, type: String
  field :story_goal, type: String
  field :story_benefit, type: String

  validates :story_role, :story_goal, :story_benefit, :presence => true
  validates :reference, :presence => true, :uniqueness => { }

  before_validation :assign_new_reference

  belongs_to :organisation

  def story
    "As a #{story_role} I need to #{story_goal} so that #{story_benefit}"
  end

  def whole_reference
    "N#{reference}"
  end

  private
  def assign_new_reference
    last_assigned = Need.order_by([:reference, :desc]).first
    self.reference ||= last_assigned.present? ? last_assigned.reference + 1 : 1
  end

end
