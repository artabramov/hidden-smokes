Feature: Select download

Background: Authorize users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@download @select
Scenario Outline: Select download when download_id not found
    # select download
Given set request token from global param 'admin_token' 
  And set request placeholder 'download_id' from value '<download_id>'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '404'
  And error loc is 'download_id'
  And error type is 'resource_not_found'

Examples:
| download_id |
| -1          |
| 0           |
| 9999999999  |

@download @select
Scenario: Select download when app is locked
    # insert collection
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And save response param 'collection_id' to global param 'collection_id'
    # insert document
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And save response param 'revision_id' to global param 'revision_id'
    # download revision
Given set request token from global param 'admin_token' 
  And set request placeholder 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'desc'
 When send 'GET' request to url 'downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And save id from response list 'downloads' to global param 'download_id'
    # lock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
    # select dowload
Given set request token from global param 'admin_token' 
  And set request placeholder 'download_id' from global param 'download_id'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '503'
    # unlock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/unlock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
    # select dowload
Given set request token from global param 'admin_token' 
  And set request placeholder 'download_id' from global param 'download_id'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'download_user'
  And response contains '5' params
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@download @select
Scenario: Select download when user is admin
    # insert collection
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And save response param 'collection_id' to global param 'collection_id'
    # insert document
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And save response param 'revision_id' to global param 'revision_id'
    # download revision
Given set request token from global param 'admin_token' 
  And set request placeholder 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'desc'
 When send 'GET' request to url 'downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And save id from response list 'downloads' to global param 'download_id'
    # select dowload
Given set request token from global param 'admin_token' 
  And set request placeholder 'download_id' from global param 'download_id'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'download_user'
  And response contains '5' params
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@download @select
Scenario: Select download when user is editor
    # select download
Given set request token from global param 'editor_token' 
  And set request placeholder 'download_id' from value '<download_id>'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@download @select
Scenario: Select download when user is writer
    # select download
Given set request token from global param 'writer_token' 
  And set request placeholder 'download_id' from value '<download_id>'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@download @select
Scenario: Select download when user is reader
    # select download
Given set request token from global param 'reader_token' 
  And set request placeholder 'download_id' from value '<download_id>'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@download @select
Scenario: Select download when token is missing
    # select download
Given delete request token 
  And set request placeholder 'download_id' from value '1'
 When send 'GET' request to url 'download/:download_id'
 Then response code is '403'
