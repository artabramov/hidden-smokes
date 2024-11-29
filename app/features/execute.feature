Feature: Execute action

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@execute
Scenario: Execute handler when lock mode is enabled
    # enable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # execute action
Given set request header token from global param 'admin_token'
  And set request body param 'action' from value 'action'
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'execute'
 Then response code is '423'
    # disable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # execute action
Given set request header token from global param 'admin_token'
  And set request body param 'action' from value 'action'
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'execute'
 Then response code is '200'
  And response contains '0' params

@execute
Scenario: Execute action when user is admin
    # execute action
Given set request header token from global param 'admin_token'
  And set request body param 'action' from value 'action'
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'execute'
 Then response code is '200'
  And response contains '0' params

@execute
Scenario: Lock when user is editor
    # execute action
Given set request header token from global param 'editor_token'
  And set request body param 'action' from value 'action'
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'execute'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@execute
Scenario: Lock when user is writer
    # action execute
Given set request header token from global param 'writer_token'
  And set request body param 'action' from value 'action'
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'execute'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@execute
Scenario: Lock when user is reader
    # execute action
Given set request header token from global param 'reader_token'
  And set request body param 'action' from value 'action'
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'execute'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@execute
Scenario: Lock app when token is missing
    # execute action
Given delete request header token
  And set request body param 'action' from value 'action'
  And set request body param 'params' from value 'dict'
 When send 'POST' request to url 'execute'
 Then response code is '403'
