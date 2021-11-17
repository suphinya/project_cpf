require 'rails_helper'
def prepare
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
end

def loginAsAdmin
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
  visit login_path
  fill_in 'username', with: '00001'
  fill_in 'password', with: '00001'
  click_button 'LOGIN'

end
describe "SessionsController", type: :feature do
  describe 'invalid password' do
    it 'if loggin was invalid password' do
      visit login_path
      fill_in 'username', with: '00001'
      fill_in 'password', with: '000z01'
      click_button 'LOGIN'
      expect(page).to have_content('Oop Sorry ! Make sure your username and password are correct !!')
    end

  describe ' valid password' do
    it 'if loggin was invalid password' do
      prepare()
      visit login_path
      fill_in 'username', with: '00001'
      fill_in 'password', with: '00001'
      click_button 'LOGIN'
      expect(page).to have_content('ไก่ตกราว')
    end

    it 'if loggin was invalid password' do
      prepare()
      visit login_path
      fill_in 'username', with: '11111'
      fill_in 'password', with: '11111'
      click_button 'LOGIN'
      expect(page).to have_content('SCHEDULE')
    end
  end
  end
end



describe "SessionsController", type: :feature do
  describe 'invalid password' do
    it 'if loggin was invalid password' do
      loginAsAdmin()
      click_link 'ไก่ตกราว'
      expect(page).to have_content('แผนก : ไก่ตกราว')
    end
    it 'if loggin was invalid password' do
      loginAsAdmin()
      click_link 'ไก่ตกราว'
      click_link 'Plan'
      expect(page).to have_content("PLAN")
    end
  end
end
=begin
describe DashboardsController do
	before(:each) do
    current_user = FactoryGirl.attributes_for(:user)
  end
  describe 'If not logged_in' do
    it 'should redirect to login path' do
			get :index
			expect(response).to redirect_to(login_path)
    end
  end
  describe 'If login' do
    it 'should redirect to login path' do
      allow(controller).to receive(:authorized)
			get :index
			expect(response).to redirect_to(login_path)
    end
  end
end
=end
