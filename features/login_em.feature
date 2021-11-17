Feature: Login employee

Background: Start from the login page
	Given I am on login page

Scenario: user sign in successful
	Given a valid employee
	And I should see "Username"
	And I should see "Password"
	When I fill in "username" with "11111"
	And I fill in "password" with "11111"
	And I press "LOGIN"
	Then I should be on schedule page


