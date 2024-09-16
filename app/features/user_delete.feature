Feature: Delete user

Background: Authorize users, register a new user
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # register a new user
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And save response param 'user_id' to global param 'user_id'

@user @delete
Scenario Outline: Delete user when user_id not found
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from value '<user_id>'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '404'
  And error loc is 'user_id'
  And error type is 'resource_not_found'
    # delete user
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

Examples:
| user_id    |
| -1         |
| 0          |
| 9999999999 |

@user @delete
Scenario: Delete user when app is locked
    # lock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'service/lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
    # delete user
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '503'
    # unlock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'service/unlock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
    # delete user
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

@user @delete
Scenario: Delete user when current user is admin
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

@user @delete
Scenario: Delete user when current user is editor
Given set request token from global param 'editor_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'
    # delete user
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

@user @delete
Scenario: Delete user when current user is writer
Given set request token from global param 'writer_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'
    # delete user
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

@user @delete
Scenario: Delete user when current user is reader
Given set request token from global param 'reader_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'
    # delete user
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

@user @delete
Scenario: Delete user when token is missing
Given delete request token 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '403'
    # delete user
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
