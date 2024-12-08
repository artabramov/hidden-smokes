Feature: Change lock mode

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@locked @change
Scenario: Change lock mode when user is admin
    # enable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # disable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params

@locked @change
Scenario: Change lock mode when user is editor
    # enable lock mode
Given set request header token from global param 'editor_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'locked'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # disable lock mode
Given set request header token from global param 'editor_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'locked'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@locked @change
Scenario: Change lock mode when user is writer
    # enable lock mode
Given set request header token from global param 'writer_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'locked'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # disable lock mode
Given set request header token from global param 'writer_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'locked'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@locked @change
Scenario: Change lock mode when user is reader
    # enable lock mode
Given set request header token from global param 'reader_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'locked'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # disable lock mode
Given set request header token from global param 'reader_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'locked'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@locked @change
Scenario: Change lock mode app when token is missing
    # enable lock mode
Given delete request header token
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'locked'
 Then response code is '403'
    # disable lock mode
Given delete request header token
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'locked'
 Then response code is '403'
