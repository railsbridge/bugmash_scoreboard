Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :participant do |factory|
  factory.email { Factory.next :email }
  factory.name 'John McClane'
  factory.github_id 'jmmclane'
  factory.lighthouse_id 'jmmclane'
  factory.password 'sekrit'
  factory.password_confirmation 'sekrit'
end
