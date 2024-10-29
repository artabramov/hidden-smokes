Feature: Execute custom command

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@custom @execute
Scenario: Custom execute when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # custom execute
Given set request header token from global param 'admin_token' 
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'custom'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # custom execute
Given set request header token from global param 'admin_token' 
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'custom'
 Then response code is '200'
  And response contains '0' params

@custom @execute
Scenario: Custom execute when user is admin
    # custom execute
Given set request header token from global param 'admin_token' 
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'custom'
 Then response code is '200'
  And response contains '0' params

@custom @execute
Scenario: Lock when user is editor
    # custom execute
Given set request header token from global param 'editor_token'
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'custom'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@custom @execute
Scenario: Lock when user is writer
    # custom execute
Given set request header token from global param 'writer_token'
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'custom'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@custom @execute
Scenario: Lock when user is reader
    # custom execute
Given set request header token from global param 'reader_token'
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'custom'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@custom @execute
Scenario: Lock app when token is missing
    # custom execute
Given delete request header token
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'custom'
 Then response code is '403'
