Feature: Upload userpic

Background: Authorize users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@userpic @upload
Scenario: Upload userpic when user_id is invalid
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'reader_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '403'
  And error loc is 'user_id'
  And error type is 'resource_forbidden'

@userpic @upload
Scenario: Upload userpic when file is invalid
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'admin_id'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '422'
  And error loc is 'file'
  And error type is 'mimetype_unsupported'

@userpic @upload
Scenario Outline: Upload userpic when file is correct
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'admin_id'
  And set request file from sample format '<file_extension>'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'

Examples:
| file_extension |
| jpeg           |
| webp           |
| png            |
| gif            |

@userpic @upload
Scenario: Upload userpic when user is admin
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'admin_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'

@userpic @upload
Scenario: Upload userpic when user is editor
Given set request token from global param 'editor_token' 
  And set request placeholder 'user_id' from global param 'editor_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'

@userpic @upload
Scenario: Upload userpic when user is writer
Given set request token from global param 'writer_token' 
  And set request placeholder 'user_id' from global param 'writer_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'

@userpic @upload
Scenario: Upload userpic when user is reader
Given set request token from global param 'reader_token' 
  And set request placeholder 'user_id' from global param 'reader_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '200'
  And response params contain 'user_id'

@userpic @upload
Scenario: Upload userpic when token is missing
Given delete request token 
  And set request placeholder 'user_id' from global param 'reader_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'user/:user_id/userpic'
 Then response code is '403'
