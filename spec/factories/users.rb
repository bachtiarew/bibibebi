# create_table "users", force: :cascade do |t|
#     t.string   "email",           limit: 255
#     t.string   "password_digest", limit: 255
#     t.string   "role",            limit: 255
#     t.string   "firstname",       limit: 255
#     t.string   "lastname",        limit: 255
#     t.string   "bornplace",       limit: 255
#     t.date     "borndate"
#     t.text     "address",         limit: 65535
#     t.datetime "created_at"
#     t.datetime "updated_at"
#     t.string   "gender",          limit: 255
#     t.string   "phone_number",    limit: 255
#   end

FactoryGirl.define do
	factory :user do
		email "loerm@ipsum.test"
		password "loremipsum"
		password_confirmation "loremipsum"
		role "babysitter"
		firstname "lorem"
		lastname "ipsum"
		bornplace "lorem"
		borndate "1990-12-12"
		address "loremipsum"
		gender "male"
		phone_number 11111
	end
end
