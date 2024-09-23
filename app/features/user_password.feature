Feature: Change user password

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@user @password
Scenario: Change password when user_id is invalid
    # update password
Given set request header token from global param 'admin_token'
  And set request path param 'user_id' from global param 'reader_id'
  And set request body param 'current_password' from config param 'reader_password'
  And set request body param 'updated_password' from config param 'reader_password'
 When send 'PUT' request to url 'user/:user_id/password'
 Then response code is '403'
  And error loc is 'path' and 'user_id'
  And error type is 'resource_forbidden'
  And response contains '1' params

@user @password
Scenario: Change password when current_password is invalid
    # update password
Given set request header token from global param 'admin_token'
  And set request path param 'user_id' from global param 'admin_id'
  And set request body param 'current_password' from value 'current-password'
  And set request body param 'updated_password' from config param 'admin_password'
 When send 'PUT' request to url 'user/:user_id/password'
 Then response code is '422'
  And error loc is 'body' and 'current_password'
  And error type is 'value_invalid'
  And response contains '1' params

@user @password
Scenario Outline: Change password when updated_password is invalid
    # update password
Given set request header token from global param 'admin_token'
  And set request path param 'user_id' from global param 'admin_id'
  And set request body param 'current_password' from config param 'admin_password'
  And set request body param 'updated_password' from value '<user_password>'
 When send 'PUT' request to url 'user/:user_id/password'
 Then response code is '422'
  And error loc is 'body' and 'updated_password'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| user_password | error_type       |
| none          | missing          |
| string(0)     | string_too_short |
| string(1)     | string_too_short |
| string(5)     | string_too_short |

# @user @password
# Scenario: Change password when app is locked
#     # lock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/lock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'True'
#     # change password
# Given set request header token from global param 'admin_token'
#   And set request path param 'user_id' from global param 'admin_id'
#   And set request body param 'current_password' from config param 'admin_password'
#   And set request body param 'updated_password' from config param 'admin_password'
#  When send 'PUT' request to url 'user/:user_id/password'
#  Then response code is '503'
#     # unlock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/unlock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'False'
#     # change password
# Given set request header token from global param 'admin_token'
#   And set request path param 'user_id' from global param 'admin_id'
#   And set request body param 'current_password' from config param 'admin_password'
#   And set request body param 'updated_password' from config param 'admin_password'
#  When send 'PUT' request to url 'user/:user_id/password'
#  Then response code is '200'
#   And response params contain 'user_id'
#   And response contains '1' params

@user @password
Scenario: Change password when user is admin
    # update password
Given set request header token from global param 'admin_token'
  And set request path param 'user_id' from global param 'admin_id'
  And set request body param 'current_password' from config param 'admin_password'
  And set request body param 'updated_password' from config param 'admin_password'
 When send 'PUT' request to url 'user/:user_id/password'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @password
Scenario: Change password when user is editor
    # update password
Given set request header token from global param 'editor_token'
  And set request path param 'user_id' from global param 'editor_id'
  And set request body param 'current_password' from config param 'editor_password'
  And set request body param 'updated_password' from config param 'editor_password'
 When send 'PUT' request to url 'user/:user_id/password'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @password
Scenario: Change password when user is writer
    # update password
Given set request header token from global param 'writer_token'
  And set request path param 'user_id' from global param 'writer_id'
  And set request body param 'current_password' from config param 'writer_password'
  And set request body param 'updated_password' from config param 'writer_password'
 When send 'PUT' request to url 'user/:user_id/password'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @password
Scenario: Change password when user is reader
    # update password
Given set request header token from global param 'reader_token'
  And set request path param 'user_id' from global param 'reader_id'
  And set request body param 'current_password' from config param 'reader_password'
  And set request body param 'updated_password' from config param 'reader_password'
 When send 'PUT' request to url 'user/:user_id/password'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@user @password
Scenario: Change password when token is missing
    # update password
Given delete request header token
  And set request path param 'user_id' from global param 'reader_id'
  And set request body param 'current_password' from config param 'reader_password'
  And set request body param 'updated_password' from config param 'reader_password'
 When send 'PUT' request to url 'user/:user_id/password'
 Then response code is '403'
