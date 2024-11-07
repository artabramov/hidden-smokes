Feature: System telemetry

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@telemetry @retrieve
Scenario: Retrieve telemetry when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '1'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
   # retrieve telemetry
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'telemetry'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '0'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
   # retrieve telemetry
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'telemetry'
 Then response code is '200'
  And response contains '30' params

@telemetry @retrieve
Scenario: Retrieve telemetry when user is admin
   # retrieve telemetry
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'telemetry'
 Then response code is '200'
  And response contains '30' params

@telemetry @retrieve
Scenario: Retrieve telemetry when user is editor
   # retrieve telemetry
Given set request header token from global param 'editor_token' 
 When send 'GET' request to url 'telemetry'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@telemetry @retrieve
Scenario: Retrieve telemetry when user is writer
   # retrieve telemetry
Given set request header token from global param 'writer_token' 
 When send 'GET' request to url 'telemetry'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@telemetry @retrieve
Scenario: Retrieve telemetry when user is reader
   # retrieve telemetry
Given set request header token from global param 'reader_token' 
 When send 'GET' request to url 'telemetry'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@telemetry @retrieve
Scenario: Retrieve telemetry when token is missing
   # retrieve telemetry
Given delete request header token 
 When send 'GET' request to url 'telemetry'
 Then response code is '403'
