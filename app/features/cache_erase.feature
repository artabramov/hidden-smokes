Feature: Erase the cache

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@cache @erase
Scenario: Erase cache when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
   # erase cache
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'cache'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
   # erase cache
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'cache'
 Then response code is '200'
  And response contains '0' params

@cache @erase
Scenario: Erase cache when user is admin
   # erase cache
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'cache'
 Then response code is '200'
  And response contains '0' params

@cache @erase
Scenario: Erase cache when user is editor
   # erase cache
Given set request header token from global param 'editor_token' 
 When send 'DELETE' request to url 'cache'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@cache @erase
Scenario: Erase cache when user is writer
   # erase cache
Given set request header token from global param 'writer_token' 
 When send 'DELETE' request to url 'cache'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@cache @erase
Scenario: Erase cache when user is reader
   # erase cache
Given set request header token from global param 'reader_token' 
 When send 'DELETE' request to url 'cache'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@cache @erase
Scenario: Erase cache when token is missing
   # erase cache
Given delete request header token 
 When send 'DELETE' request to url 'cache'
 Then response code is '403'
