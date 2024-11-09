Feature: Select revision

Background: Auth users and upload document
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
  And save response param 'revision_id' to global param 'revision_id'
    # remove file from request
Given delete request file

@revision @select
Scenario Outline: Select revision when revision_id is incorrect
    # select revision
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request path param 'revision_id' from value '<revision_id>'
 When send 'GET' request to url 'document/:document_id/revision/:revision_id'
 Then response code is '404'
  And error loc is 'path' and 'revision_id'
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
| revision_id |
| -1          |
| 0           |
| 9999999999  |

@revision @select
Scenario Outline: Select revision when document_id is incorrect
    # select revision
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from value '<document_id>'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'document/:document_id/revision/:revision_id'
 Then response code is '404'
  And error loc is 'path' and 'revision_id'
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
| document_id |
| -1           |
| 0            |
| 9999999999   |

@revision @select
Scenario: Select revision when lock mode is enabled
    # enable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # select revision
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'document/:document_id/revision/:revision_id'
 Then response code is '423'
    # disable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # select revision
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'document/:document_id/revision/:revision_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'user_name'
  And response params contain 'document_id'
  And response params contain 'revision_filename'
  And response params contain 'revision_size'
  And response params contain 'revision_mimetype'
  And response params contain 'thumbnail_url'
  And response contains '9' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@revision @select
Scenario: Select revision when user is admin
    # select revision
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'document/:document_id/revision/:revision_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'user_name'
  And response params contain 'document_id'
  And response params contain 'revision_filename'
  And response params contain 'revision_size'
  And response params contain 'revision_mimetype'
  And response params contain 'thumbnail_url'
  And response contains '9' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@revision @select
Scenario: Select revision when user is editor
    # select revision
Given set request header token from global param 'editor_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'document/:document_id/revision/:revision_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'user_name'
  And response params contain 'document_id'
  And response params contain 'revision_filename'
  And response params contain 'revision_size'
  And response params contain 'revision_mimetype'
  And response params contain 'thumbnail_url'
  And response contains '9' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@revision @select
Scenario: Select revision when user is writer
    # select revision
Given set request header token from global param 'writer_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'document/:document_id/revision/:revision_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'user_name'
  And response params contain 'document_id'
  And response params contain 'revision_filename'
  And response params contain 'revision_size'
  And response params contain 'revision_mimetype'
  And response params contain 'thumbnail_url'
  And response contains '9' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@revision @select
Scenario: Select revision when user is reader
    # select revision
Given set request header token from global param 'reader_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'document/:document_id/revision/:revision_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'user_name'
  And response params contain 'document_id'
  And response params contain 'revision_filename'
  And response params contain 'revision_size'
  And response params contain 'revision_mimetype'
  And response params contain 'thumbnail_url'
  And response contains '9' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@revision @select
Scenario: Select revision when token is missing
    # select revision
Given delete request header token
  And set request path param 'document_id' from global param 'document_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'document/:document_id/revision/:revision_id'
 Then response code is '403'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params
