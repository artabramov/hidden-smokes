Feature: Delete favorite

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

@favorite @delete
Scenario Outline: Delete favorite when favorite_id is not found
    # insert favorite
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # delete favorite
Given set request token from global param 'admin_token' 
  And set request placeholder 'favorite_id' from value '<favorite_id>'
 When send 'DELETE' request to url 'favorite/:favorite_id'
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

@favorite @delete
Scenario: Delete favorite when user is admin
    # insert favorite
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # delete favorite
Given set request token from global param 'admin_token' 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'DELETE' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'favorite_id'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@favorite @delete
Scenario: Delete favorite when user is admin-to-reader
    # insert favorite
Given set request token from global param 'reader_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # delete favorite
Given set request token from global param 'admin_token' 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'DELETE' request to url 'favorite/:favorite_id'
 Then response code is '403'
  And error loc is 'favorite_id'
  And error type is 'resource_forbidden'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@favorite @delete
Scenario: Delete favorite when user is editor
    # insert favorite
Given set request token from global param 'editor_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # delete favorite
Given set request token from global param 'editor_token' 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'DELETE' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'favorite_id'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@favorite @delete
Scenario: Delete favorite when user is writer
    # insert favorite
Given set request token from global param 'writer_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # delete favorite
Given set request token from global param 'writer_token' 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'DELETE' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'favorite_id'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@favorite @delete
Scenario: Delete favorite when user is reader
    # insert favorite
Given set request token from global param 'reader_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # delete favorite
Given set request token from global param 'reader_token' 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'DELETE' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'favorite_id'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@favorite @delete
Scenario: Delete favorite when token is missing
    # insert favorite
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And save response param 'favorite_id' to global param 'favorite_id'
    # delete favorite
Given delete request token 
  And set request placeholder 'favorite_id' from global param 'favorite_id'
 When send 'DELETE' request to url 'favorite/:favorite_id'
 Then response code is '403'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
