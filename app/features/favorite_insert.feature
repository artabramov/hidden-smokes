Feature: Insert favorite

Background: Auth users and upload a document
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

@favorite @insert
Scenario Outline: Insert favorite when document_id is not found
    # insert favorite
Given set request header token from global param 'admin_token' 
  And set request body param 'document_id' from value '<document_id>'
 When send 'POST' request to url 'favorite'
 Then response code is '422'
  And error loc is 'body' and 'document_id'
  And error type is 'value_invalid'
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
| 0           |
| -1          |
| 9999999999  |

@favorite @insert
Scenario: Insert favorite when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '1'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # insert favorite
Given set request header token from global param 'admin_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '0'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # insert favorite
Given set request header token from global param 'admin_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@favorite @insert
Scenario: Insert favorite when user is admin
    # insert favorite
Given set request header token from global param 'admin_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@favorite @insert
Scenario: Insert favorite when user is editor
    # insert favorite
Given set request header token from global param 'editor_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@favorite @insert
Scenario: Insert favorite when user is writer
    # insert favorite
Given set request header token from global param 'writer_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@favorite @insert
Scenario: Insert favorite when user is reader
    # insert favorite
Given set request header token from global param 'reader_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@favorite @insert
Scenario: Insert favorite when token is missing
    # insert favorite
Given delete request header token
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '403'
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params
