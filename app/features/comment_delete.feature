Feature: Select update

Background: Authorize users, create collection and document
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

@comment @delete
Scenario Outline: Delete comment when comment_id not found
Given set request token from global param 'admin_token' 
  And set request placeholder 'comment_id' from value '<comment_id>'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
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

@comment @delete
Scenario: Delete comment when collection is locked
    # insert comment
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
    # lock collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
  And set request param 'is_locked' from value '1'
  And set request param 'collection_name' from fake 'collection_name'
 When send 'PUT' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
    # delete comment
Given set request token from global param 'admin_token' 
  And set request placeholder 'comment_id' from global param 'comment_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '423'
  And error loc is 'comment_id'
  And error type is 'resource_locked'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @delete
Scenario: Delete comment when user is admin
    # insert comment
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
    # delete comment
Given set request token from global param 'admin_token' 
  And set request placeholder 'comment_id' from global param 'comment_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'comment_id'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @delete
Scenario: Delete comment when user is editor
    # insert comment
Given set request token from global param 'editor_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
    # delete comment
Given set request token from global param 'editor_token' 
  And set request placeholder 'comment_id' from global param 'comment_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'comment_id'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @delete
Scenario: Delete comment when user is writer
    # insert comment
Given set request token from global param 'writer_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
    # delete comment
Given set request token from global param 'writer_token' 
  And set request placeholder 'comment_id' from global param 'comment_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @delete
Scenario: Delete comment when user is writer-to-reader
    # insert comment
Given set request token from global param 'writer_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
    # delete comment
Given set request token from global param 'reader_token' 
  And set request placeholder 'comment_id' from global param 'comment_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @delete
Scenario: Delete comment when user is writer-to-admin
    # insert comment
Given set request token from global param 'writer_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
    # delete comment
Given set request token from global param 'admin_token' 
  And set request placeholder 'comment_id' from global param 'comment_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '403'
  And error loc is 'comment_id'
  And error type is 'resource_forbidden'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @delete
Scenario: Delete comment when token is missing
    # insert comment
Given set request token from global param 'writer_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
    # delete comment
Given delete request token 
  And set request placeholder 'comment_id' from global param 'comment_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '403'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
