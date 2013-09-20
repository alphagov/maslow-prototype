class Need
  include Mongoid::Document

  field :reference, type: Integer

  field :story_role,    type: String
  field :story_goal,    type: String
  field :story_benefit, type: String
  field :justification, type: String
  field :evidence,      type: String
  field :done_criteria, type: String
  field :completion,    type: Integer, default: 0

  ROLES = [
    "user"
  ]
  JUSTIFICATIONS = [
    "only_the_government_provides",
    "clear_demand_from_users",
    "legally_obliged_to_provide",
    "prerequisite_to_government_service",
    "government_provides_or_pays_for",
    "inherent_to_rights_and_obligations",
    "advice_for_statutory_obligation"
  ]
  COMPLETION_FIELDS = [:story_role, :story_goal, :story_benefit, :justification, :evidence, :done_criteria]

  validates :story_goal, :presence => true
  validates :reference, :presence => true, :uniqueness => { }
  validates :justification, :inclusion => { :in => JUSTIFICATIONS, :allow_blank => true }
  validates :story_role, :inclusion => { :in => ROLES, :allow_blank => true }
  validates :completion, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }

  before_validation :assign_new_reference, :update_completion

  has_and_belongs_to_many :organisations

  embeds_many :annotations
  accepts_nested_attributes_for :annotations, :allow_destroy => true, :reject_if => :all_blank

  def story
    "As a #{story_role} I need to #{story_goal} so that #{story_benefit}"
  end

  def whole_reference
    "#{reference}"
  end

  private
  def assign_new_reference
    last_assigned = Need.order_by([:reference, :desc]).first
    self.reference ||= last_assigned.present? ? last_assigned.reference + 1 : 1
  end

  def update_completion
    completed_fields = COMPLETION_FIELDS.select {|f| self.send(f).present? }
    self.completion = (completed_fields.size.to_f/COMPLETION_FIELDS.size.to_f * 100).to_i
  end

end
