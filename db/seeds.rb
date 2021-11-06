# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

all_humen = [
	{:username => '00001' , :password_digest => '00001' , :name => 'suphinya' , :surname => 'wu' , :position => 'leader' , 
		:department1 => 'kai tok row' , :department2 => 'ton kon kai' , :department3 => 'kill kai'},
	{:username => '11111' , :password_digest => '11111' , :name => 'onpinya' , :surname => 'phok' , :position => 'employee' , 
		:department1 => 'kai tok row' , :department2 => '' , :department3 => ''},
	{:username => '22222' , :password_digest => '22222' , :name => 'donyapa' , :surname => 'praman' , :position => 'employee' , 
		:department1 => 'kai tok row' , :department2 => '' , :department3 => ''},
	{:username => '33333' , :password_digest => '33333' , :name => 'chanda' , :surname => 'soon' , :position => 'employee' , 
		:department1 => 'kai tok row' , :department2 => '' , :department3 => ''},
	{:username => '44444' , :password_digest => '44444' , :name => 'thatphoom' , :surname => 'pao' , :position => 'employee' , 
		:department1 => 'kai tok row' , :department2 => '' , :department3 => ''}
]

password = ['00001','11111','22222','33333','44444']

all_humen.each do |humen|
	User.create(humen)
end

password.each do |password|
	a = User.find_by_username(password)
	a.password = password
	a.password_confirmation = password
	a.save
end


