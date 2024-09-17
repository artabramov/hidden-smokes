Feature: Select collection

Background: Authorize users and create collection
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

@collection @select
Scenario Outline: Select collection when collection_id not found
Given set request token from global param 'reader_token' 
  And set request placeholder 'collection_id' from value '<collection_id>'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '404'
  And error loc is 'collection_id'
  And error type is 'resource_not_found'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

Examples:
| collection_id |
| -1            |
| 0             |
| 9999999999    |

@collection @select
Scenario: Select collection when app is locked
    # lock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
    # select collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '503'
    # unlock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/unlock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
    # select collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'is_locked'
  And response params contain 'collection_name'
  And response params contain 'collection_summary'
  And response params contain 'documents_count'
  And response params contain 'documents_size'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'collection_user'
  And response contains '12' params
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@collection @select
Scenario: Select collection when user is admin
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'is_locked'
  And response params contain 'collection_name'
  And response params contain 'collection_summary'
  And response params contain 'documents_count'
  And response params contain 'documents_size'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'collection_user'
  And response contains '12' params
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@collection @select
Scenario: Select collection when user is editor
Given set request token from global param 'editor_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'is_locked'
  And response params contain 'collection_name'
  And response params contain 'collection_summary'
  And response params contain 'documents_count'
  And response params contain 'documents_size'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'collection_user'
  And response contains '12' params
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@collection @select
Scenario: Select collection when user is writer
Given set request token from global param 'writer_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'is_locked'
  And response params contain 'collection_name'
  And response params contain 'collection_summary'
  And response params contain 'documents_count'
  And response params contain 'documents_size'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'collection_user'
  And response contains '12' params
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@collection @select
Scenario: Select collection when user is reader
Given set request token from global param 'reader_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'is_locked'
  And response params contain 'collection_name'
  And response params contain 'collection_summary'
  And response params contain 'documents_count'
  And response params contain 'documents_size'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'collection_user'
  And response contains '12' params
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@collection @select
Scenario: Select collection when token is missing
Given delete request token
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '403'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
