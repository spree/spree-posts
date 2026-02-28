FactoryBot.define do
  factory :post, class: Spree::Post do
    store { Spree::Store.default || create(:store) }
    post_category { association(:post_category, store: store) }
    title { FFaker::Lorem.sentence }
    content { FFaker::Lorem.paragraph }
    published_at { Time.current }
    association :author, factory: :admin_user

    trait :with_image do
      image { Rack::Test::UploadedFile.new(Spree::Core::Engine.root.join('spec/fixtures/thinking-cat.jpg'), 'image/jpeg') }
    end

    trait :published do
      published_at { Time.current }
    end

    trait :unpublished do
      published_at { nil }
    end
  end

  factory :post_category, class: Spree::PostCategory do
    sequence(:title) { |n| "Category ##{n + 1}" }
    description { FFaker::Lorem.sentence }
    store { Spree::Store.default || create(:store) }
  end
end
