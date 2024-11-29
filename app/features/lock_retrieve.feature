Feature: Retrieve lock mode

Background: Auth users
    # auth users
Given auth with user role 'admin'

@locked @retrieve
Scenario: Retrieve lock mode
   # retrieve lock mode
When send 'GET' request to url 'locked'
Then response code is '200'
 And response params contain 'is_locked'
 And response params contain 'locked_date'
 And response contains '2' params

@locked @retrieve
Scenario: Retrieve lock mode when lock mode is changed
    # enable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # retrieve lock mode
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response params contain 'locked_date'
  And response param 'is_locked' equals 'True'
  And response contains '2' params
    # disable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # retrieve lock mode
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response params contain 'locked_date'
  And response param 'is_locked' equals 'False'
  And response param 'locked_date' equals '0'
  And response contains '2' params
