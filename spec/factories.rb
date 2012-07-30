FactoryGirl.define do

  sequence(:email) { |n| "email_#{n}@example.com" }
  sequence(:username) { |n| "username_#{n}" }

	factory :user, :aliases => [:owner, :author] do
		username
		email { "#{username}@example.com".downcase }
		password 'secret'
		password_confirmation 'secret'
		confirmed_at Time.now
	end

  factory :quote do
    owner
  	subject_verb 'My father said'
  	text 'Son, can you ...'
  end

  factory :quote_activity do
    user
    quote
  end
  
  factory :comment do
  	author 
  	quote
  	body 'comment body'
  end

  factory :comment_activity do
    user
    quote
    comment
  end
end