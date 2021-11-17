Feature: see details

Background: Start from the login page
	Given I am on login page
	And a valid leader
	And I should see "Username"
	And I should see "Password"
	When I fill in "username" with "00001"
	And I fill in "password" with "00001"
	And I press "LOGIN"

Scenario: leader see details actual page
	Given I should be on dashboards page
	And I should see "Dash Board"
	And I should see "จัดการแผนก"
	And I should see "ไก่ตกราว" "ไก่ตกบันได" "ไก่กุ๊กกุ๊ก"
	When I follow "ไก่ตกราว"
	Then I should be on ไก่ตกราว page
	And I should see "แผนก : ไก่ตกราว"
	
	When I select "all" from "time_in"
	And I fill in "date_work_date_work" date field with "2021-11-18"
	And I press "select"
	
	Then I should see "ชื่อ-นามสกุล" "เวลาเข้างาน" "เวลาออกงาน" "OT"
	And I should see "จำนวนคน : 0 / 2"
	And I should see "onpinya phok" "donyapa praman"
