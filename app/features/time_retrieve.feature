Feature: Retrieve time

Background: Auth users
    # auth users
Given auth with user role 'admin'

@time @retrieve
Scenario: Retrieve time
   # retrieve time
When send 'GET' request to url 'time'
Then response code is '200'
 And response params contain 'unix_timestamp'
 And response params contain 'timezone_name'
 And response params contain 'timezone_offset'
 And response contains '3' params

@time @retrieve
Scenario: Retrieve time when protected mode is changed
    # enable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '1'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # retrieve time
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'time'
 Then response code is '200'
  And response params contain 'unix_timestamp'
  And response params contain 'timezone_name'
  And response params contain 'timezone_offset'
  And response contains '3' params
    # disable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '0'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # retrieve time
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'time'
 Then response code is '200'
  And response params contain 'unix_timestamp'
  And response params contain 'timezone_name'
  And response params contain 'timezone_offset'
  And response contains '3' params
