FactoryGirl.define do
  initialize_with { new(attributes) }

  factory :repo, class: GitStats::GitData::Repo do
    path "repo_path"
    factory :test_repo do
      path 'spec/integration/test_repo'
    end
  end

  factory :author, class: GitStats::GitData::Author do
    sequence(:name) { |i| "author#{i}" }
    sequence(:email) { |i| "author#{i}@gmail.com" }
    association :repo, strategy: :build
  end

  factory :commit, class: GitStats::GitData::Commit do
    sequence(:hash) { |i| i }
    sequence(:stamp) { |i| i }
    sequence(:date) { |i| Date.new(i) }
    association :repo, strategy: :build
    association :author, strategy: :build
  end
end