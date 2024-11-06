Feature: Select comment

Background: Auth users, upload document and insert comment
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # create collection
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And response contains '1' params
  And save response param 'collection_id' to global param 'collection_id'
    # upload document
Given set request header token from global param 'admin_token' 
  And set request file from sample format 'pdf'
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'POST' request to url 'collection/:collection_id/document'
 Then response code is '201'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And response contains '2' params
  And save response param 'document_id' to global param 'document_id'
    # remove file from request
Given delete request file
    # insert comment
Given set request header token from global param 'admin_token' 
  And set request body param 'document_id' from global param 'document_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And response contains '1' params
  And save response param 'comment_id' to global param 'comment_id'

@comment @select
Scenario Outline: Select comment when document_id not found
    # select comment
Given set request header token from global param 'admin_token' 
  And set request path param 'comment_id' from value '<comment_id>'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '404'
  And error loc is 'path' and 'comment_id'
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
| comment_id |
| -1         |
| 0          |
| 9999999999 |

@comment @select
Scenario: Select comment when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '1'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # select comment
Given set request header token from global param 'admin_token' 
  And set request path param 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '0'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # select comment
Given set request header token from global param 'admin_token' 
  And set request path param 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
  And response contains '7' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@comment @select
Scenario: Select comment when user is admin
    # select comment
Given set request header token from global param 'admin_token' 
  And set request path param 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
  And response contains '7' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@comment @select
Scenario: Select comment when user is editor
    # select comment
Given set request header token from global param 'editor_token' 
  And set request path param 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
  And response contains '7' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@comment @select
Scenario: Select comment when user is writer
    # select comment
Given set request header token from global param 'writer_token' 
  And set request path param 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
  And response contains '7' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@comment @select
Scenario: Select comment when user is reader
    # select comment
Given set request header token from global param 'reader_token' 
  And set request path param 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
  And response contains '7' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@comment @select
Scenario: Select comment when token is missing
    # select comment
Given delete request header token 
  And set request path param 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '403'
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params
