Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |factory|
  factory.email { Factory.next :email }
  factory.password "secret"
  factory.password_confirmation "secret" 
end
