Feature: see my assign shift detail 

Background: Start from the login page
	Given I am on login page
	And a valid employee
	And I should see "Username"
	And I should see "Password"
	When I fill in "username" with "11111"
	And I fill in "password" with "11111"
	And I press "LOGIN"
	Then I should be on schedule page
	

Scenario: see detail onpinya
	Given I am on schedule page
	And I should see "schedule ตารางงาน onpinya"
	And I should see "Today's Plan" "Monthly's Plan"
	And I should see "วันที่" "เวลาเข้างาน" "เวลาออกงาน" "OT"
	
