FactoryBot.define do
  factory :condition do
    name { 'Acanthosis nigricans' }
    source_url { 'https://api.service.nhs.uk/nhs-website-content/conditions/acanthosis-nigricans/' }
    slug { 'acanthosis-nigricans' }
    description { 'A skin condition' }
  end
end
