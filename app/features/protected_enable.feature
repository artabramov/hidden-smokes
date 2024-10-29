Feature: Enable protected mode

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@protected @create
Scenario: Enable protected mode when user is admin
    # enable protected mode
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # disable protected mode
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params

@protected @create
Scenario: Enable protected mode when user is editor
    # enable protected mode
Given set request header token from global param 'editor_token' 
 When send 'POST' request to url 'protected'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@protected @create
Scenario: Enable protected mode when user is writer
    # enable protected mode
Given set request header token from global param 'writer_token' 
 When send 'POST' request to url 'protected'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@protected @create
Scenario: Enable protected mode when user is reader
    # enable protected mode
Given set request header token from global param 'reader_token' 
 When send 'POST' request to url 'protected'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@protected @create
Scenario: Enable protected mode app when token is missing
    # enable protected mode
Given delete request header token 
 When send 'POST' request to url 'protected'
 Then response code is '403'
