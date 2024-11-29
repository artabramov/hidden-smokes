Feature: Delete user

Background: Auth users, register a new user
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # register a new user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'
  And response contains '3' params
  And save response param 'user_id' to global param 'user_id'

@user @delete
Scenario Outline: Delete user when user_id not found
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from value '<user_id>'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '404'
  And error loc is 'path' and 'user_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

Examples:
| user_id    |
| -1         |
| 0          |
| 9999999999 |

@user @delete
Scenario: Delete user when lock mode is enabled
    # enable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '423'
    # disable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @delete
Scenario: Delete user when current user is admin
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @delete
Scenario: Delete user when current user is editor
    # delete user
Given set request header token from global param 'editor_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @delete
Scenario: Delete user when current user is writer
    # delete user
Given set request header token from global param 'writer_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @delete
Scenario: Delete user when current user is reader
    # delete user
Given set request header token from global param 'reader_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @delete
Scenario: Delete user when token is missing
    # delete user
Given delete request header token 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '403'
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params
