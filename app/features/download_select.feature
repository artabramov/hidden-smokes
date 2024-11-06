Feature: Select download

Background: Auth users, upload a document, download revision
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
    # download revision
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'document/:document_id/revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty

@download @select
Scenario Outline: Select download when download_id is incorrect
    # select download
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id' 
  And set request path param 'download_id' from value '<download_id>'
 When send 'GET' request to url 'document/:document_id/download/:download_id'
 Then response code is '404'
  And error loc is 'path' and 'download_id'
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
| download_id |
| -1          |
| 0           |
| 9999999999  |

@download @select
Scenario Outline: Select download when document_id is incorrect
    # list downloads
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'desc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params
  And save id from response list 'downloads' to global param 'download_id'
    # select download
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from value '<document_id>' 
  And set request path param 'download_id' from global param 'download_id'
 When send 'GET' request to url 'document/:document_id/download/:download_id'
 Then response code is '404'
  And error loc is 'path' and 'download_id'
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
| document_id |
| -1           |
| 0            |
| 9999999999   |

@download @select
Scenario: Select download when protected mode is enabled
    # list downloads
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'desc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params
  And save id from response list 'downloads' to global param 'download_id'
    # enable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '1'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # select dowload
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request path param 'download_id' from global param 'download_id'
 When send 'GET' request to url 'document/:document_id/download/:download_id'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '0'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # select dowload
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request path param 'download_id' from global param 'download_id'
 When send 'GET' request to url 'document/:document_id/download/:download_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'download_user'
  And response contains '5' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@download @select
Scenario: Select download when user is admin
    # list downloads
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'desc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params
  And save id from response list 'downloads' to global param 'download_id'
    # select dowload
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request path param 'download_id' from global param 'download_id'
 When send 'GET' request to url 'document/:document_id/download/:download_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'download_user'
  And response contains '5' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@download @select
Scenario: Select download when user is editor
    # select download
Given set request header token from global param 'editor_token'
  And set request path param 'mdiafile_id' from global param 'document_id'
  And set request path param 'download_id' from value '123'
 When send 'GET' request to url 'document/:document_id/download/:download_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@download @select
Scenario: Select download when user is writer
    # select download
Given set request header token from global param 'writer_token' 
  And set request path param 'mdiafile_id' from global param 'document_id'
  And set request path param 'download_id' from value '123'
 When send 'GET' request to url 'document/:document_id/download/:download_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@download @select
Scenario: Select download when user is reader
    # select download
Given set request header token from global param 'reader_token' 
  And set request path param 'mdiafile_id' from global param 'document_id'
  And set request path param 'download_id' from value '123'
 When send 'GET' request to url 'document/:document_id/download/:download_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@download @select
Scenario: Select download when token is missing
    # select download
Given delete request header token 
  And set request path param 'mdiafile_id' from global param 'document_id'
  And set request path param 'download_id' from value '123'
 When send 'GET' request to url 'document/:document_id/download/:download_id'
 Then response code is '403'
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params
