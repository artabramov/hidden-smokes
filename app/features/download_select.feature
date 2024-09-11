Feature: Select download

Background: Authorize users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@download @select
Scenario Outline: Select download when download_id not found
Given set request token from global param 'admin_token' 
  And set request placeholder 'download_id' from value '<download_id>'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '404'
  And error loc is 'download_id'
  And error type is 'resource_not_found'

Examples:
| download_id |
| -1          |
| 0           |
| 9999999999  |

@download @select
Scenario: Select download when user is editor
Given set request token from global param 'editor_token' 
  And set request placeholder 'download_id' from value '<download_id>'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@download @select
Scenario: Select download when user is writer
Given set request token from global param 'writer_token' 
  And set request placeholder 'download_id' from value '<download_id>'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@download @select
Scenario: Select download when user is reader
Given set request token from global param 'reader_token' 
  And set request placeholder 'download_id' from value '<download_id>'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@download @select
Scenario: Select download when token is missing
Given delete request token 
  And set request placeholder 'download_id' from value '1'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '403'
