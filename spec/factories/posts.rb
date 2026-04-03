FactoryBot.define do
  factory :post do
    title { "Post Title" }
    subtitle { "Post Subtitle" }
    content { "Post Content" }
    association :user, :admin
    newsletter_flag { false }
    newsletter_sent { false }
    draft { false }

    trait :draft do
      draft { true }
      published_at { nil }
    end

    trait :published do
      draft { false }
      published_at { Time.current }
    end
  end
end
