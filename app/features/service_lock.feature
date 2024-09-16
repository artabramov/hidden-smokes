Feature: Service lock

Background: Authorize users and create option
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@service @lock @unlock
Scenario: Execute lock when user is admin
    # lock
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'service/lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
    # unlock
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'service/unlock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'

@service @lock @unlock
Scenario: Execute lock when user is editor
Given set request token from global param 'editor_token' 
 When send 'GET' request to url 'service/lock'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@service @lock @unlock
Scenario: Execute lock when user is writer
Given set request token from global param 'writer_token' 
 When send 'GET' request to url 'service/lock'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@service @lock @unlock
Scenario: Execute lock when user is reader
Given set request token from global param 'reader_token' 
 When send 'GET' request to url 'service/lock'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@service @lock @unlock
Scenario: Execute lock when token is missing
Given delete request token 
 When send 'GET' request to url 'service/lock'
 Then response code is '403'
