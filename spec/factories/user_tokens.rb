FactoryBot.define do
  factory :user_token do
    token_set { {} }
    active_tenant_id { '' }
  end
end
