Feature: Download document

Background: Auth users, upload and replace document
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # upload document
Given set request header token from global param 'admin_token' 
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And response contains '2' params
  And save response param 'document_id' to global param 'document_id'
    # remove file from request
Given delete request file
    # replace document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document/:document_id'
 Then response code is '201'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And response contains '2' params

@document @download
Scenario Outline: Download document when document_id is not found
    # download document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from value '<document_id>'
 When send 'GET' request to url 'document/:document_id/download'
 Then response code is '404'
  And error loc is 'path' and 'document_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| document_id |
| -1           |
| 0            |
| 9999999999   |

@document @download
Scenario: Download revision when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # download document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id/download'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # download document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id/download'
 Then response code is '200'
  And response content is not empty
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@document @download
Scenario: Download document when user is admin
    # download document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id/download'
 Then response code is '200'
  And response content is not empty
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@document @download
Scenario: Download document when user is editor
    # download document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id/download'
 Then response code is '200'
  And response content is not empty
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@document @download
Scenario: Download document when user is writer
    # download document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id/download'
 Then response code is '200'
  And response content is not empty
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@document @download
Scenario: Download document when user is reader
    # download document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id/download'
 Then response code is '200'
  And response content is not empty
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@document @download
Scenario: Download document when token is missing
    # download document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'GET' request to url 'document/:document_id/download'
 Then response code is '200'
  And response content is not empty
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params
