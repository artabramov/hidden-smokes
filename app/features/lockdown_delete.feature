Feature: Unlock the app

Background: Auth users and create lock
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lockdown'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params

@lockdown @delete
Scenario: Unlock when user is admin
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lockdown'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params

@lockdown @delete
Scenario: Unlock app when user is editor
    # delete lock
Given set request header token from global param 'editor_token' 
 When send 'DELETE' request to url 'lockdown'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lockdown'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params

@lockdown @delete
Scenario: Unlock app when user is writer
    # delete lock
Given set request header token from global param 'writer_token' 
 When send 'DELETE' request to url 'lockdown'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lockdown'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params

@lockdown @delete
Scenario: Unlock app when user is reader
    # delete lock
Given set request header token from global param 'reader_token' 
 When send 'DELETE' request to url 'lockdown'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lockdown'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params

@lockdown @delete
Scenario: Lock app when token is missing
    # delete lock
Given delete request header token 
 When send 'DELETE' request to url 'lockdown'
 Then response code is '403'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lockdown'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
