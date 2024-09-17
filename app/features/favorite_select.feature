Feature: Select favorite

Background: Authorize users, create collection and document
    # auth users
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

@favorite @select
Scenario Outline: Select favorite when favorite_id is not found
    # insert favorite
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given set request token from global param 'admin_token' 
  And set request placeholder 'favorite_id' from value '<favorite_id>'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '404'
  And error loc is 'favorite_id'
  And error type is 'resource_not_found'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

Examples:
| favorite_id |
| -1          |
| 0           |
| 9999999999  |

@favorite @select
Scenario: Select favorite when app is locked
    # insert favorite
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # lock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
    # select favorite
Given set request token from global param 'admin_token' 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '503'
    # unlock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/unlock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
    # select favorite
Given set request token from global param 'admin_token' 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'favorite_document'
  And response contains '5' params
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@favorite @select
Scenario: Select favorite when user is admin
    # insert favorite
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given set request token from global param 'admin_token' 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'favorite_document'
  And response contains '5' params
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@favorite @select
Scenario: Select favorite when user is admin-to-reader
    # insert favorite
Given set request token from global param 'reader_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given set request token from global param 'admin_token' 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '403'
  And error loc is 'favorite_id'
  And error type is 'resource_forbidden'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@favorite @select
Scenario: Select favorite when user is editor
    # insert favorite
Given set request token from global param 'editor_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given set request token from global param 'editor_token' 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'favorite_document'
  And response contains '5' params
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@favorite @select
Scenario: Select favorite when user is writer
    # insert favorite
Given set request token from global param 'writer_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given set request token from global param 'writer_token' 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'favorite_document'
  And response contains '5' params
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@favorite @select
Scenario: Select favorite when user is reader
    # insert favorite
Given set request token from global param 'reader_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given set request token from global param 'reader_token' 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'favorite_document'
  And response contains '5' params
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@favorite @select
Scenario: Select favorite when token is missing
    # insert favorite
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given delete request token 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '403'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
