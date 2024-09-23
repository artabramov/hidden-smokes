Feature: System lock

Background: Authorize users and create option
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@system @lock @unlock
Scenario: Lock/unlock app when user is admin
    # lock app
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # unlock app
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params

@system @lock @unlock
Scenario: Lock app when user is editor
    # lock app
Given set request header token from global param 'editor_token' 
 When send 'POST' request to url 'lock'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params

@system @lock @unlock
Scenario: Unlock app when user is editor
    # lock app
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # unlock app
Given set request header token from global param 'editor_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # unlock app
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params

@system @lock @unlock
Scenario: Lock app when user is writer
    # lock app
Given set request header token from global param 'writer_token' 
 When send 'POST' request to url 'lock'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params

@system @lock @unlock
Scenario: Unlock app when user is writer
    # lock app
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # unlock app
Given set request header token from global param 'writer_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # unlock app
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params

@system @lock @unlock
Scenario: Lock app when user is reader
    # lock app
Given set request header token from global param 'reader_token' 
 When send 'POST' request to url 'lock'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params

@system @lock @unlock
Scenario: Unlock app when user is reader
    # lock app
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # unlock app
Given set request header token from global param 'reader_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # unlock app
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params

@system @lock @unlock
Scenario: Lock app when token is missing
    # lock app
Given delete request header token 
 When send 'POST' request to url 'lock'
 Then response code is '403'
