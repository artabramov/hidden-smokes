Feature: Upload partner emblem

Background: Auth users, create partner
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'

@partner @emblem @upload
Scenario Outline: Upload partner emblem when partner_id is not found
    # upload userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from value '<partner_id>'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'partner/:partner_id/emblem'
 Then response code is '404'
  And error loc is 'path' and 'partner_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_id  |
| -1         |
| 0          |
| 9999999999 |

@partner @emblem @upload
Scenario: Upload partner emblem when file mimetype is not supported
    # upload emblem
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'partner/:partner_id/emblem'
 Then response code is '422'
  And error loc is 'body' and 'file'
  And error type is 'mimetype_unsupported'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @emblem @upload
Scenario Outline: Upload partner emblem when file mimetype is correct
    # upload file
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request file from sample format '<file_extension>'
 When send 'POST' request to url 'partner/:partner_id/emblem'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| file_extension |
| jpeg           |
| webp           |
| png            |
| gif            |

@partner @emblem @upload
Scenario: Upload partner emblem when app is locked
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # upload file
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'partner/:partner_id/emblem'
 Then response code is '423'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # upload userpic
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'partner/:partner_id/emblem'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @emblem @upload
Scenario: Upload partner emblem when user is admin
    # upload file
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'partner/:partner_id/emblem'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @emblem @upload
Scenario: Upload partner emblem when user is editor
    # upload file
Given set request header token from global param 'editor_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'partner/:partner_id/emblem'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @emblem @upload
Scenario: Upload partner emblem when user is writer
    # upload file
Given set request header token from global param 'writer_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'partner/:partner_id/emblem'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @emblem @upload
Scenario: Upload partner emblem when user is reader
    # upload file
Given set request header token from global param 'reader_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'partner/:partner_id/emblem'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @emblem @upload
Scenario: Upload partner emblem when token is missing
    # upload file
Given delete request header token 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request file from sample format 'jpeg'
 When send 'POST' request to url 'partner/:partner_id/emblem'
 Then response code is '403'
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
