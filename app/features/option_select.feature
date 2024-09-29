Feature: Select option

Background: Auth users and create option
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # set option
Given set request header token from global param 'admin_token' 
  And set request body param 'option_key' from fake 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '200'
  And response params contain 'option_key'
  And save response param 'option_key' to global param 'option_key'

@option @select
Scenario Outline: Select option when option_key not found
    # select option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from value '<option_key>'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '404'
  And error loc is 'path' and 'option_key'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'

  Examples:
| option_key |
| tabs       |
| spaces     |
| string(1)  |
| string(2)  |
| string(40) |
| string(41) |

@option @select
Scenario: Select option when app is locked
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # select option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '423'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # select option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'option_key'
  And response params contain 'option_value'
  And response contains '5' params
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @select
Scenario: Select option when user is admin
    # select option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'option_key'
  And response params contain 'option_value'
  And response contains '5' params
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @select
Scenario: Select option when user is editor
    # select option
Given set request header token from global param 'editor_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @select
Scenario: Select option when user is writer
    # select option
Given set request header token from global param 'writer_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @select
Scenario: Select option when user is reader
    # select option
Given set request header token from global param 'reader_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @select
Scenario: Select option when token is missing
    # select option
Given delete request header token
  And set request path param 'option_key' from global param 'option_key'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '403'
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params
