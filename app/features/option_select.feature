Feature: Select option

Background: Authorize users and create option
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # insert/update option
Given set request token from global param 'admin_token' 
  And set request placeholder 'option_key' from fake 'option_key'
  And set request param 'option_value' from fake 'option_value'
 When send 'PUT' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
  And save response param 'option_key' to global param 'option_key'

@option @select
Scenario Outline: Select option when option_key not found
Given set request token from global param 'admin_token' 
  And set request placeholder 'option_key' from value '<option_key>'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '404'
  And error loc is 'option_key'
  And error type is 'resource_not_found'
    # delete option
Given set request token from global param 'admin_token' 
  And set request placeholder 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'

  Examples:
| option_key |
| string(2)  |
| string(40) |

@option @select
Scenario Outline: Select option when option_key is invalid
Given set request token from global param 'admin_token' 
  And set request placeholder 'option_key' from value '<option_key>'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '422'
  And error loc is 'option_key'
  And error type is '<error_type>'
    # delete option
Given set request token from global param 'admin_token' 
  And set request placeholder 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'

  Examples:
| option_key | error_type              |
| tabs       | string_pattern_mismatch |
| spaces     | string_pattern_mismatch |
| string(1)  | string_pattern_mismatch |
| string(41) | string_pattern_mismatch |

@option @select
Scenario: Select option when user is admin
Given set request token from global param 'admin_token' 
  And set request placeholder 'option_key' from global param 'option_key'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'option_key'
  And response params contain 'option_value'
    # delete option
Given set request token from global param 'admin_token' 
  And set request placeholder 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'

@option @select
Scenario: Select option when user is editor
Given set request token from global param 'editor_token' 
  And set request placeholder 'option_key' from global param 'option_key'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'
    # delete option
Given set request token from global param 'admin_token' 
  And set request placeholder 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'

@option @select
Scenario: Select option when user is writer
Given set request token from global param 'writer_token' 
  And set request placeholder 'option_key' from global param 'option_key'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'
    # delete option
Given set request token from global param 'admin_token' 
  And set request placeholder 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'

@option @select
Scenario: Select option when user is reader
Given set request token from global param 'reader_token' 
  And set request placeholder 'option_key' from global param 'option_key'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'
    # delete option
Given set request token from global param 'admin_token' 
  And set request placeholder 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'

@option @select
Scenario: Select option when token is missing
Given delete request token
  And set request placeholder 'option_key' from global param 'option_key'
 When send 'GET' request to url 'option/:option_key'
 Then response code is '403'
    # delete option
Given set request token from global param 'admin_token' 
  And set request placeholder 'option_key' from global param 'option_key'
 When send 'DELETE' request to url 'option/:option_key'
 Then response code is '200'
  And response params contain 'option_key'
