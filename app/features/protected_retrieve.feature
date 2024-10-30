Feature: Retrieve protected mode

Background: Auth users
    # auth users
Given auth with user role 'admin'

@protected @retrieve
Scenario: Retrieve protected mode
   # retrieve protected mode
When send 'GET' request to url 'protected'
Then response code is '200'
 And response params contain 'is_protected'
 And response params contain 'protected_date'
 And response contains '2' params

@protected @retrieve
Scenario: Retrieve protected mode when protected mode is changed
    # enable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '1'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # retrieve protected mode
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response params contain 'protected_date'
  And response param 'is_protected' equals 'True'
  And response contains '2' params
    # disable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '0'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # retrieve protected mode
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response params contain 'protected_date'
  And response param 'is_protected' equals 'False'
  And response param 'protected_date' equals '0'
  And response contains '2' params
