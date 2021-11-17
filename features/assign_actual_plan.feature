Feature:  leader assign shift from actual page

Background: Start from the login page to actual page
	Given I am on login page
	And a valid leader
	And I should see "Username"
	And I should see "Password"
	When I fill in "username" with "00001"
	And I fill in "password" with "00001"
	When I press "LOGIN"
	Then I should be on dashboards page
	When I follow "ไก่ตกราว"
	Then I should be on ไก่ตกราว page


Scenario: assign shift (all people)
	Given I am on ไก่ตกราว page
	When I follow "Plan"
	Then I should be on ไก่ตกราว plan page
	And I fill in "emp_date" date field with "2021-11-18"
	And I select "00:00 - 09:00" from "time"
	When I check "check_all"
	And I fill in "emp_OT" with "2.5"
	And I press "Submit"
	Then I should be on ไก่ตกราว plan page


	
Scenario: assign shift (select people)
	Given I am on ไก่ตกราว page
	When I follow "Plan"
	Then I should be on ไก่ตกราว plan page
	And I fill in "emp_date" date field with "2021-11-20"
	And I select "00:00 - 09:00" from "time"
	When I check "onpinya" in table
	And I check "donyapa" in table

	And I fill in "emp_OT" with "2.5"
	And I press "Submit"
	Then I should be on ไก่ตกราว plan page

	When I fill in "emp_date" date field with "2021-11-20"
	And I press "select"
	Then I should see "onpinya phok" "00:00" "09:00" "1"
	And I should see "donyapa praman" "00:00" "09:00" "1"
