Feature: Upload userpic

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@userpic @upload
Scenario Outline: Upload userpic when user_id is not found
    # upload userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from value '<user_id>'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '404'
  And error loc is 'path' and 'user_id'
  And error type is 'resource_not_found'
  And response contains '1' params

Examples:
| user_id    |
| -1         |
| 0          |
| 9999999999 |

@userpic @upload
Scenario: Upload userpic when user_id is invalid
    # upload userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'reader_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '403'
  And error loc is 'path' and 'user_id'
  And error type is 'resource_forbidden'
  And response contains '1' params

@userpic @upload
Scenario: Upload userpic when file is invalid
    # upload userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'admin_id'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '422'
  And error loc is 'body' and 'file'
  And error type is 'mimetype_unsupported'
  And response contains '1' params

@userpic @upload
Scenario Outline: Upload userpic when file is correct
    # upload userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'admin_id'
  And set request file from sample format '<file_extension>'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

Examples:
| file_extension |
| jpeg           |
| webp           |
| png            |
| gif            |

@userpic @upload
Scenario: Upload userpic when protected mode is enabled
    # lock app
    # enable protected mode
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # upload userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'admin_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # upload userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'admin_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@userpic @upload
Scenario: Upload userpic when user is admin
    # upload userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'admin_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@userpic @upload
Scenario: Upload userpic when user is editor
    # upload userpic
Given set request header token from global param 'editor_token' 
  And set request path param 'user_id' from global param 'editor_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@userpic @upload
Scenario: Upload userpic when user is writer
    # upload userpic
Given set request header token from global param 'writer_token' 
  And set request path param 'user_id' from global param 'writer_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@userpic @upload
Scenario: Upload userpic when user is reader
    # upload userpic
Given set request header token from global param 'reader_token' 
  And set request path param 'user_id' from global param 'reader_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

@userpic @upload
Scenario: Upload userpic when token is missing
    # upload userpic
Given delete request header token 
  And set request path param 'user_id' from global param 'reader_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '403'
