Feature: Select comment

Background: Authorize users, create collection, document and comment
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # insert collection
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from fake 'collection_name'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And save response param 'collection_id' to global param 'collection_id'
    # insert document
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'
  And save response param 'document_id' to global param 'document_id'
    # insert comment
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'

@comment @select
Scenario Outline: Select comment when document_id not found
Given set request token from global param 'admin_token' 
  And set request placeholder 'comment_id' from value '<comment_id>'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '404'
  And error loc is 'comment_id'
  And error type is 'resource_not_found'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

Examples:
| comment_id |
| -1         |
| 0          |
| 9999999999 |

@comment @select
Scenario: Select comment when user is admin
Given set request token from global param 'admin_token' 
  And set request placeholder 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @select
Scenario: Select comment when app is locked
    # lock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
    # select comment
Given set request token from global param 'admin_token' 
  And set request placeholder 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '503'
    # unlock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/unlock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
    # select comment
Given set request token from global param 'admin_token' 
  And set request placeholder 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @select
Scenario: Select comment when user is editor
Given set request token from global param 'editor_token' 
  And set request placeholder 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @select
Scenario: Select comment when user is writer
Given set request token from global param 'writer_token' 
  And set request placeholder 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @select
Scenario: Select comment when user is reader
Given set request token from global param 'reader_token' 
  And set request placeholder 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @select
Scenario: Select comment when token is missing
Given delete request token 
  And set request placeholder 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '403'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
