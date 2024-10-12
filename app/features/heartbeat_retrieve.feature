Feature: Retrieve heartbeat

Background: Auth users
    # auth users
Given auth with user role 'admin'

@heartbeat @retrieve
Scenario: Retrieve heartbeat
   # retrieve heartbeat
When send 'GET' request to url 'heartbeat'
Then response code is '200'
 And response params contain 'unix_timestamp'
 And response params contain 'timezone_name'
 And response params contain 'timezone_offset'
 And response params contain 'is_locked'
 And response params contain 'lock_time'
 And response contains '5' params

@heartbeat @retrieve
Scenario: Retrieve heartbeat when lock is changed
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # retrieve heartbeat
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'heartbeat'
 Then response code is '200'
  And response params contain 'unix_timestamp'
  And response params contain 'timezone_name'
  And response params contain 'timezone_offset'
  And response params contain 'is_locked'
  And response params contain 'lock_time'
  And response param 'is_locked' equals 'True'
  And response contains '5' params
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # retrieve heartbeat
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'heartbeat'
 Then response code is '200'
  And response params contain 'unix_timestamp'
  And response params contain 'timezone_name'
  And response params contain 'timezone_offset'
  And response params contain 'is_locked'
  And response params contain 'lock_time'
  And response param 'is_locked' equals 'False'
  And response param 'lock_time' equals '0'
  And response contains '5' params
