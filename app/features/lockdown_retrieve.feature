Feature: Retrieve the lock

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@lockdown @retrieve
Scenario: Retrieve the lock when user is admin
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lockdown'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # retrieve lock
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'lockdown'
 Then response code is '200'
  And response params contain 'is_locked'
  And response params contain 'lockdown_time'
  And response param 'is_locked' equals 'True'
  And response contains '2' params
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lockdown'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # retrieve lock
Given set request header token from global param 'admin_token' 
 When send 'GET' request to url 'lockdown'
 Then response code is '200'
  And response params contain 'is_locked'
  And response params contain 'lockdown_time'
  And response param 'is_locked' equals 'False'
  And response param 'lockdown_time' equals '0'
  And response contains '2' params

@lockdown @retrieve
Scenario: Retrieve the lock when user is editor
    # retrieve lock
Given set request header token from global param 'editor_token' 
 When send 'GET' request to url 'lockdown'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params

@lockdown @retrieve
Scenario: Retrieve the lock when user is writer
    # retrieve lock
Given set request header token from global param 'writer_token' 
 When send 'GET' request to url 'lockdown'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params

@lockdown @retrieve
Scenario: Retrieve the lock when user is reader
    # retrieve lock
Given set request header token from global param 'reader_token' 
 When send 'GET' request to url 'lockdown'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params

@lockdown @retrieve
Scenario: Retrieve the lock when token is missing
    # retrieve lock
Given delete request header token 
 When send 'GET' request to url 'lockdown'
 Then response code is '403'
