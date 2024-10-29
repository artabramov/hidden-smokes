Feature: Update option

Background: Auth users and create option
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # insert option
Given set request header token from global param 'admin_token' 
  And set request body param 'option_key' from fake 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params
  And save response param 'option_key' to global param 'option_key'

@option @update
Scenario Outline: Update option when option_key not found
    # update option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from value '<option_key>'
  And set request body param 'option_value' from fake 'option_value'
 When send 'PUT' request to url 'option/:option_key'
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
  And response contains '1' params

  Examples:
| option_key |
| tabs       |
| spaces     |
| string(1)  |
| string(2)  |
| string(40) |
| string(41) |

@option @update
Scenario: Update option when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # update option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'PUT' request to url 'option/:option_key'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # update option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'PUT' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @update
Scenario: Update option when user is admin
    # update option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'PUT' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @update
Scenario: Update option when user is editor
    # update option
Given set request header token from global param 'editor_token' 
  And set request path param 'option_key' from global param 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'PUT' request to url 'option/:option_key'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @update
Scenario: Update option when user is writer
    # update option
Given set request header token from global param 'writer_token' 
  And set request path param 'option_key' from global param 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'PUT' request to url 'option/:option_key'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @update
Scenario: Update option when user is reader
    # update option
Given set request header token from global param 'reader_token' 
  And set request path param 'option_key' from global param 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'PUT' request to url 'option/:option_key'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @update
Scenario: Update option when token is missing
    # update option
Given set request header token from global param 'editor_token' 
  And set request path param 'option_key' from global param 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'PUT' request to url 'option/:option_key'
 Then response code is '403'
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params
