Feature: Insert option

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@option @insert
Scenario Outline: Insert option when option_key is invalid
    # insert option
Given set request header token from global param 'admin_token' 
  And set request body param 'option_key' from value '<option_key>'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '422'
  And error loc is 'body' and 'option_key'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| option_key | error_type              |
| none       | missing                 |
| tabs       | string_pattern_mismatch |
| spaces     | string_pattern_mismatch |
| string(1)  | string_pattern_mismatch |
| string(41) | string_pattern_mismatch |

@option @insert
Scenario: Insert option when option_key is duplicated
    # insert option
Given set request header token from global param 'admin_token' 
  And set request body param 'option_key' from fake 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params
  And save response param 'option_key' to global param 'option_key'
    # insert option
Given set request header token from global param 'admin_token' 
  And set request body param 'option_key' from global param 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '422'
  And error loc is 'body' and 'option_key'
  And error type is 'value_duplicated'
  And response contains '1' params
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @insert
Scenario Outline: Insert option when option_key is correct
    # insert option
Given set request header token from global param 'admin_token' 
  And set request body param 'option_key' from value '<option_key>'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params
  And save response param 'option_key' to global param 'option_key'
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

Examples:
| option_key |
| string(2)  |
| string(40) |

@option @insert
Scenario: Insert option when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '1'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # insert option
Given set request header token from global param 'admin_token' 
  And set request body param 'option_key' from fake 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '0'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # insert option
Given set request header token from global param 'admin_token' 
  And set request body param 'option_key' from fake 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params
  And save response param 'option_key' to global param 'option_key'
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @insert
Scenario: Insert option when user is admin
    # insert option
Given set request header token from global param 'admin_token' 
  And set request body param 'option_key' from fake 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params
  And save response param 'option_key' to global param 'option_key'
    # delete option
Given set request header token from global param 'admin_token' 
  And set request path param 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And response contains '1' params

@option @insert
Scenario: Insert option when user is editor
    # insert option
Given set request header token from global param 'editor_token' 
  And set request body param 'option_key' from fake 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@option @insert
Scenario: Insert option when user is writer
    # insert option
Given set request header token from global param 'writer_token' 
  And set request body param 'option_key' from fake 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@option @insert
Scenario: Insert option when user is reader
    # insert option
Given set request header token from global param 'reader_token' 
  And set request body param 'option_key' from fake 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@option @insert
Scenario: Insert option when token is missing
    # insert option
Given delete request header token 
  And set request body param 'option_key' from fake 'option_key'
  And set request body param 'option_value' from fake 'option_value'
 When send 'POST' request to url 'option'
 Then response code is '403'
