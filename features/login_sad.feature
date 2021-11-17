Feature: Login

Scenario: user sign in unsuccessful(not fill)
	Given I am on login page
	And I should see "Username"
	And I should see "Password"
	When I fill in "username" with ""
	And I fill in "password" with ""
	And I press "LOGIN"
	Then I should be on login page
	And I should see "Oop Sorry ! Make sure your username and password are correct !!"

Scenario: user sign in unsuccessful(fill wrong)
	Given I am on login page
	And I should see "Username"
	And I should see "Password"
	When I fill in "username" with "xxx"
	And I fill in "password" with "xxx"
	And I press "LOGIN"
	Then I should be on login page
	And I should see "Oop Sorry ! Make sure your username and password are correct !!"