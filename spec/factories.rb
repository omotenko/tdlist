FactoryGirl.define do 
	factory :user do 
		name  "Oleg"
		email "o.motenko@mail.ru"
		password "Moten1992ol"
		password_confirmation "Moten1992ol"
	end

	factory :message do
  		title "hello"
  		description "first message"
  		user
	end
end