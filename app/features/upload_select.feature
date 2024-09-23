Feature: Select upload

Background: Auth users and upload document
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # upload document
Given set request header token from global param 'admin_token' 
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'
  And response params contain 'upload_id'
  And response contains '2' params
  And save response param 'document_id' to global param 'document_id'
  And save response param 'upload_id' to global param 'upload_id'
    # remove file from request
Given delete request file

@upload @select
Scenario Outline: Select upload when upload_id is not found
    # select upload
Given set request header token from global param 'admin_token' 
  And set request path param 'upload_id' from value '<upload_id>'
 When send 'GET' request to url 'upload/:upload_id'
 Then response code is '404'
  And error loc is 'path' and 'upload_id'
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
| upload_id |
| -1          |
| 0           |
| 9999999999  |

# @upload @select
# Scenario: Select upload when app is locked
#     # lock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/lock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'True'
#     # select upload
# Given set request header token from global param 'admin_token' 
#   And set request path param 'upload_id' from global param 'upload_id'
#  When send 'GET' request to url 'upload/:upload_id'
#  Then response code is '503'
#     # unlock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/unlock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'False'
#     # select upload
# Given set request header token from global param 'admin_token' 
#   And set request path param 'upload_id' from global param 'upload_id'
#  When send 'GET' request to url 'upload/:upload_id'
#  Then response code is '200'
#   And response params contain 'id'
#   And response params contain 'created_date'
#   And response params contain 'user_id'
#   And response params contain 'document_id'
#   And response params contain 'is_latest'
#   And response params contain 'upload_size'
#   And response params contain 'original_filename'
#   And response params contain 'original_size'
#   And response params contain 'original_mimetype'
#   And response params contain 'thumbnail_url'
#   And response params contain 'downloads_count'
#   And response params contain 'upload_user'
#   And response contains '12' params
#     # delete collection
# Given set request header token from global param 'admin_token' 
#   And set request path param 'collection_id' from global param 'collection_id'
#  When send 'DELETE' request to url 'collection/:collection_id'
#  Then response code is '200'
#   And response params contain 'collection_id'

@upload @select
Scenario: Select upload when user is admin
    # select upload
Given set request header token from global param 'admin_token' 
  And set request path param 'upload_id' from global param 'upload_id'
 When send 'GET' request to url 'upload/:upload_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'is_latest'
  And response params contain 'upload_size'
  And response params contain 'original_filename'
  And response params contain 'original_size'
  And response params contain 'original_mimetype'
  And response params contain 'thumbnail_url'
  And response params contain 'downloads_count'
  And response params contain 'upload_user'
  And response contains '12' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@upload @select
Scenario: Select upload when user is editor
    # select upload
Given set request header token from global param 'editor_token' 
  And set request path param 'upload_id' from global param 'upload_id'
 When send 'GET' request to url 'upload/:upload_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'is_latest'
  And response params contain 'upload_size'
  And response params contain 'original_filename'
  And response params contain 'original_size'
  And response params contain 'original_mimetype'
  And response params contain 'thumbnail_url'
  And response params contain 'downloads_count'
  And response params contain 'upload_user'
  And response contains '12' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@upload @select
Scenario: Select upload when user is writer
    # select upload
Given set request header token from global param 'writer_token' 
  And set request path param 'upload_id' from global param 'upload_id'
 When send 'GET' request to url 'upload/:upload_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'is_latest'
  And response params contain 'upload_size'
  And response params contain 'original_filename'
  And response params contain 'original_size'
  And response params contain 'original_mimetype'
  And response params contain 'thumbnail_url'
  And response params contain 'downloads_count'
  And response params contain 'upload_user'
  And response contains '12' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@upload @select
Scenario: Select upload when user is reader
    # select upload
Given set request header token from global param 'reader_token' 
  And set request path param 'upload_id' from global param 'upload_id'
 When send 'GET' request to url 'upload/:upload_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'is_latest'
  And response params contain 'upload_size'
  And response params contain 'original_filename'
  And response params contain 'original_size'
  And response params contain 'original_mimetype'
  And response params contain 'thumbnail_url'
  And response params contain 'downloads_count'
  And response params contain 'upload_user'
  And response contains '12' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@upload @select
Scenario: Select upload when token is missing
    # select upload
Given delete request header token 
  And set request path param 'upload_id' from global param 'upload_id'
 When send 'GET' request to url 'upload/:upload_id'
 Then response code is '403'
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params
