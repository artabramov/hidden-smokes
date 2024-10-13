Feature: Delete member

Background: Auth users and create member
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # insert member
Given set request header token from global param 'admin_token' 
  And set request body param 'member_name' from fake 'member_name'
  And set request body param 'member_summary' from fake 'member_summary'
  And set request body param 'member_contacts' from fake 'member_contacts'
 When send 'POST' request to url 'member'
 Then response code is '201'
  And response params contain 'member_id'
  And response contains '1' params
  And save response param 'member_id' to global param 'member_id'

@member @delete
Scenario: Delete member when member_id not found
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from value '9999999999'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '404'
  And error loc is 'path' and 'member_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
 And response params contain 'member_id'
 And response contains '1' params

@member @delete
Scenario: Delete member when app is locked
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '423'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

@member @delete
Scenario: Delete member when user is admin
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

@member @delete
Scenario: Delete member when user is editor
    # delete member
Given set request header token from global param 'editor_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

@member @delete
Scenario: Delete member when user is writer
    # delete member
Given set request header token from global param 'writer_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

@member @delete
Scenario: Delete member when user is reader
    # delete member
Given set request header token from global param 'reader_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params

@member @delete
Scenario: Delete member when token is missing
    # delete member
Given delete request header token 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '403'
    # delete member
Given set request header token from global param 'admin_token' 
  And set request path param 'member_id' from global param 'member_id'
 When send 'DELETE' request to url 'member/:member_id'
 Then response code is '200'
  And response params contain 'member_id'
  And response contains '1' params
