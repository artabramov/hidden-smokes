Feature: Select collection

Background: Auth users and create collection
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # insert collection
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And response contains '1' params
  And save response param 'collection_id' to global param 'collection_id'

@collection @select
Scenario Outline: Select collection when collection_id not found
Given set request header token from global param 'reader_token' 
  And set request path param 'collection_id' from value '<collection_id>'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '404'
  And error loc is 'path' and 'collection_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

Examples:
| collection_id |
| -1            |
| 0             |
| 9999999999    |

@collection @select
Scenario: Select collection when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # select collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # select collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'locked_date'
  And response params contain 'user_id'
  And response params contain 'is_locked'
  And response params contain 'collection_name'
  And response params contain 'collection_summary'
  And response params contain 'documents_count'
  And response params contain 'collection_user'
  And response contains '10' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@collection @select
Scenario: Select collection when user is admin
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'locked_date'
  And response params contain 'user_id'
  And response params contain 'is_locked'
  And response params contain 'collection_name'
  And response params contain 'collection_summary'
  And response params contain 'documents_count'
  And response params contain 'collection_user'
  And response contains '10' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@collection @select
Scenario: Select collection when user is editor
Given set request header token from global param 'editor_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'locked_date'
  And response params contain 'user_id'
  And response params contain 'is_locked'
  And response params contain 'collection_name'
  And response params contain 'collection_summary'
  And response params contain 'documents_count'
  And response params contain 'collection_user'
  And response contains '10' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@collection @select
Scenario: Select collection when user is writer
Given set request header token from global param 'writer_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'locked_date'
  And response params contain 'user_id'
  And response params contain 'is_locked'
  And response params contain 'collection_name'
  And response params contain 'collection_summary'
  And response params contain 'documents_count'
  And response params contain 'collection_user'
  And response contains '10' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@collection @select
Scenario: Select collection when user is reader
Given set request header token from global param 'reader_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'locked_date'
  And response params contain 'user_id'
  And response params contain 'is_locked'
  And response params contain 'collection_name'
  And response params contain 'collection_summary'
  And response params contain 'documents_count'
  And response params contain 'collection_user'
  And response contains '10' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@collection @select
Scenario: Select collection when token is missing
Given delete request header token
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'GET' request to url 'collection/:collection_id'
 Then response code is '403'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params
