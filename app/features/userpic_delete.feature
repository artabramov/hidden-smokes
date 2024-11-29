Feature: Delete userpic

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@userpic @delete
Scenario Outline: Delete userpic when user_id is not found
    # delete userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from value '<user_id>'
 When send 'DELETE' request to url 'user/:user_id/userpic'
 Then response code is '404'
  And error loc is 'path' and 'user_id'
  And error type is 'resource_not_found'
  And response contains '1' params

Examples:
| user_id    |
| -1         |
| 0          |
| 9999999999 |

@userpic @delete
Scenario: Delete userpic when user_id is invalid
    # delete userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'reader_id'
 When send 'DELETE' request to url 'user/:user_id/userpic'
 Then response code is '403'
  And error loc is 'path' and 'user_id'
  And error type is 'resource_forbidden'
  And response contains '1' params

@userpic @delete
Scenario: Delete userpic when lock mode is enabled
    # enable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # delete userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'admin_id'
 When send 'DELETE' request to url 'user/:user_id/userpic'
 Then response code is '423'
    # disable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # delete userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'admin_id'
 When send 'DELETE' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@userpic @delete
Scenario: Delete userpic when user is admin
    # delete userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'admin_id'
 When send 'DELETE' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@userpic @delete
Scenario: Delete userpic when user is editor
    # delete userpic
Given set request header token from global param 'editor_token' 
  And set request path param 'user_id' from global param 'editor_id'
 When send 'DELETE' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@userpic @delete
Scenario: Delete userpic when user is writer
    # delete userpic
Given set request header token from global param 'writer_token' 
  And set request path param 'user_id' from global param 'writer_id'
 When send 'DELETE' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@userpic @delete
Scenario: Delete userpic when user is reader
    # delete userpic
Given set request header token from global param 'reader_token' 
  And set request path param 'user_id' from global param 'reader_id'
 When send 'DELETE' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@userpic @delete
Scenario: Delete userpic when token is missing
    # delete userpic
Given delete request header token 
  And set request path param 'user_id' from global param 'reader_id'
 When send 'DELETE' request to url 'user/:user_id/userpic'
 Then response code is '403'
