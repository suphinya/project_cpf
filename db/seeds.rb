# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

all_humen = [
	{:username => '00001' , :password_digest => '00001' , :name => 'suphinya' , :surname => 'wu' , :position => 'leader' , 
		:department1 => ['ไก่ตกราว','ไก่ตกบันได','ไก่กุ๊กกุ๊ก'] },
	{:username => '11111' , :password_digest => '11111' , :name => 'onpinya' , :surname => 'phok' , :position => 'employee' , 
		:department1 => 'ไก่ตกราว' },
	{:username => '22222' , :password_digest => '22222' , :name => 'donyapa' , :surname => 'praman' , :position => 'employee' , 
		:department1 => 'ไก่ตกราว' },
	{:username => '33333' , :password_digest => '33333' , :name => 'chanda' , :surname => 'soon' , :position => 'employee' , 
		:department1 => 'ไก่ตกราว' },
	{:username => '44444' , :password_digest => '44444' , :name => 'thatphoom' , :surname => 'pao' , :position => 'employee' , 
		:department1 => 'ไก่ตกราว' },
	{:username => 'admin' , :password_digest => 'admin' , :name => 'admin' , :surname => 'admin' , :position => 'admin' , 
		:department1 => '' }
]

password = ['00001','11111','22222','33333','44444','admin']

all_humen.each do |humen|
	User.create(humen)
end

password.each do |password|
	a = User.find_by_username(password)
	a.password = password
	a.password_confirmation = password
	a.save
end


user_id = [2,3]
day = Time.current.strftime("%Y-%m-%d")
user_id.each do |id|
	u = User.find(id)
	plan = Plan.create(:date => day.to_time , :time_in => (day +' '+" 9:00").to_time,
		:time_out => (day +' '+" 18:00").to_time , :OT => 2)
	u.plans << plan
end