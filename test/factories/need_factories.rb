FactoryGirl.define do

  factory :need do
    story_role "user"
    story_goal "pay my council tax"
    story_benefit "I can avoid a fine"
    organisation
  end

end
