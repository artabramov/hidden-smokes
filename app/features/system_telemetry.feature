Feature: System telemetry

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@system @telemetry
Scenario: Retrieve telemetry when user is admin
   # retrieve telemetry
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'telemetry'
 Then response code is '200'
#   And response params contain 'unix_timestamp'
#   And response params contain 'timezone_name'
#   And response params contain 'timezone_offset'
#   And response params contain 'is_locked'
  And response contains '31' params

@system @telemetry
Scenario: Retrieve telemetry when user is editor
   # retrieve telemetry
Given set request header token from global param 'editor_token' 
 When send 'GET' request to url 'telemetry'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params

@system @telemetry
Scenario: Retrieve telemetry when user is writer
   # retrieve telemetry
Given set request header token from global param 'writer_token' 
 When send 'GET' request to url 'telemetry'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params

@system @telemetry
Scenario: Retrieve telemetry when user is reader
   # retrieve telemetry
Given set request header token from global param 'reader_token' 
 When send 'GET' request to url 'telemetry'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params

@system @telemetry
Scenario: Retrieve telemetry when token is missing
   # retrieve telemetry
Given delete request header token 
 When send 'GET' request to url 'telemetry'
 Then response code is '403'
