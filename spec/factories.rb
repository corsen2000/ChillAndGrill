Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password "test"
  f.first_name "Foo"
  f.last_name "Bar"
  f.roles []
end

Factory.define :event do |f|
  f.title "Test Event"
  f.description "This is the event we use for testing stuff."
  f.start DateTime.now
  f.private false
end