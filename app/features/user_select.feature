Feature: Select user

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@user @select
Scenario Outline: Select user when user_id not found
    # select user
Given set request header token from global param 'reader_token' 
  And set request path param 'user_id' from value '<user_id>'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '404'
  And error loc is 'path' and 'user_id'
  And error type is 'resource_not_found'
  And response contains '1' params

Examples:
| user_id    |
| -1         |
| 0          |
| 9999999999 |

@user @select
Scenario: Select user when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # select user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'admin_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # select user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'admin_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'last_login_date'
  And response params contain 'user_role'
  And response params contain 'is_active'
  And response params contain 'user_login'
  And response params contain 'first_name'
  And response params contain 'last_name'
  And response params contain 'user_signature'
  And response params contain 'user_contacts'
  And response params contain 'userpic_url'
  And response contains '12' params

@user @select
Scenario: Select user when user is admin
    # select user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'admin_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'last_login_date'
  And response params contain 'user_role'
  And response params contain 'is_active'
  And response params contain 'user_login'
  And response params contain 'first_name'
  And response params contain 'last_name'
  And response params contain 'user_signature'
  And response params contain 'user_contacts'
  And response params contain 'userpic_url'
  And response contains '12' params

@user @select
Scenario: Select user when user is editor
    # select user
Given set request header token from global param 'editor_token' 
  And set request path param 'user_id' from global param 'editor_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'last_login_date'
  And response params contain 'user_role'
  And response params contain 'is_active'
  And response params contain 'user_login'
  And response params contain 'first_name'
  And response params contain 'last_name'
  And response params contain 'user_signature'
  And response params contain 'user_contacts'
  And response params contain 'userpic_url'
  And response contains '12' params

@user @select
Scenario: Select user when user is writer
    # select user
Given set request header token from global param 'writer_token' 
  And set request path param 'user_id' from global param 'writer_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'last_login_date'
  And response params contain 'user_role'
  And response params contain 'is_active'
  And response params contain 'user_login'
  And response params contain 'first_name'
  And response params contain 'last_name'
  And response params contain 'user_signature'
  And response params contain 'user_contacts'
  And response params contain 'userpic_url'
  And response contains '12' params

@user @select
Scenario: Select user when user is reader
    # select user
Given set request header token from global param 'reader_token' 
  And set request path param 'user_id' from global param 'reader_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'last_login_date'
  And response params contain 'user_role'
  And response params contain 'is_active'
  And response params contain 'user_login'
  And response params contain 'first_name'
  And response params contain 'last_name'
  And response params contain 'user_signature'
  And response params contain 'user_contacts'
  And response params contain 'userpic_url'
  And response contains '12' params

@user @select
Scenario: Select user when token is missing
    # select user
Given delete request header token 
  And set request path param 'user_id' from global param 'admin_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '403'
