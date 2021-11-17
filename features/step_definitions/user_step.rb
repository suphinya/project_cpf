Given /^a valid employee$/ do
@employee_login_test_success =  User.create!({:username => '11111' , :password_digest => '11111' , :name => 'onpinya' , :surname => 'phok' , :position => 'employee' , 
    :department1 => 'ไก่ตกราว' })
  @employee_login_test_success.password = "11111"
  @employee_login_test_success.password_confirmation = "11111"
  @employee_login_test_success.save

  
end

Given /^a valid leader$/ do
@leader_login_test_success = User.create!({
  :username => '00001' , 
  :password_digest => '00001' , 
  :name => 'suphinya' , 
  :surname => 'wu' , 
  :position => 'leader' , 
  :department1 => ['ไก่ตกราว','ไก่ตกบันได','ไก่กุ๊กกุ๊ก'] })
  @leader_login_test_success.password = "00001"
  @leader_login_test_success.password_confirmation = "00001"
  @leader_login_test_success.save


  password = ['11111','22222','33333','44444']

  employee_test = [
  {:username => '11111' , :password_digest => '11111' , :name => 'onpinya' , :surname => 'phok' , :position => 'employee' , 
    :department1 => 'ไก่ตกราว' },
  {:username => '22222' , :password_digest => '22222' , :name => 'donyapa' , :surname => 'praman' , :position => 'employee' , 
    :department1 => 'ไก่ตกราว' },
  {:username => '33333' , :password_digest => '33333' , :name => 'chanda' , :surname => 'soon' , :position => 'employee' , 
    :department1 => 'ไก่ตกราว' },
  {:username => '44444' , :password_digest => '44444' , :name => 'thatphoom' , :surname => 'pao' , :position => 'employee' , 
    :department1 => 'ไก่ตกราว' }
  ]
  employee_test.each do |humen|
    User.create(humen)
  end

  password.each do |password|
    a = User.find_by_username(password)
    a.password = password
    a.password_confirmation = password
    a.save
  end

  user_id = [1,2,3]
  user_id.each do |id|
    u = User.find(id)
    plan = Plan.create(
      :date => "2021-11-18".to_time , 
      :time_in => "2021-11-18 9:00".to_time,
      :time_out => "2021-11-18 18:00".to_time , 
      :OT => 2)
    u.plans << plan
  end

end


When('I check {string} in table') do |string|

  employee_test = [
  {:username => '11111' , :password_digest => '11111' , :name => 'onpinya' , :surname => 'phok' , :position => 'employee' , 
    :department1 => 'ไก่ตกราว' },
  {:username => '22222' , :password_digest => '22222' , :name => 'donyapa' , :surname => 'praman' , :position => 'employee' , 
    :department1 => 'ไก่ตกราว' },
  {:username => '33333' , :password_digest => '33333' , :name => 'chanda' , :surname => 'soon' , :position => 'employee' , 
    :department1 => 'ไก่ตกราว' },
  {:username => '44444' , :password_digest => '44444' , :name => 'thatphoom' , :surname => 'pao' , :position => 'employee' , 
    :department1 => 'ไก่ตกราว' }
  ]

  password = ['11111','22222','33333','44444']
  employee_test.each do |humen|
    User.create(humen)
  end

  password.each do |password|
    a = User.find_by_username(password)
    a.password = password
    a.password_confirmation = password
    a.save
  end

  u = User.find_by_name(string)
  plan = Plan.create(
      :date => "2021-11-20".to_time , 
      :time_in => "2021-11-20 00:00".to_time,
      :time_out => "2021-11-20 09:00".to_time , 
      :OT => 1)
  u.plans << plan
end