Feature: Select revision

Background: Auth users and upload mediafile
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # upload mediafile
Given set request header token from global param 'admin_token' 
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile'
 Then response code is '201'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
  And save response param 'mediafile_id' to global param 'mediafile_id'
  And save response param 'revision_id' to global param 'revision_id'
    # remove file from request
Given delete request file

@revision @select
Scenario Outline: Select revision when revision_id is incorrect
    # select revision
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from value '<revision_id>'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id'
 Then response code is '404'
  And error loc is 'path' and 'revision_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

Examples:
| revision_id |
| -1          |
| 0           |
| 9999999999  |

@revision @select
Scenario Outline: Select revision when mediafile_id is incorrect
    # select revision
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from value '<mediafile_id>'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id'
 Then response code is '404'
  And error loc is 'path' and 'revision_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

Examples:
| mediafile_id |
| -1           |
| 0            |
| 9999999999   |

# @revision @select
# Scenario: Select revision when app is locked
#     # lock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/lock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'True'
#     # select revision
# Given set request header token from global param 'admin_token' 
#   And set request path param 'revision_id' from global param 'revision_id'
#  When send 'GET' request to url 'revision/:revision_id'
#  Then response code is '503'
#     # unlock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/unlock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'False'
#     # select revision
# Given set request header token from global param 'admin_token' 
#   And set request path param 'revision_id' from global param 'revision_id'
#  When send 'GET' request to url 'revision/:revision_id'
#  Then response code is '200'
#   And response params contain 'id'
#   And response params contain 'created_date'
#   And response params contain 'user_id'
#   And response params contain 'mediafile_id'
#   And response params contain 'revision_size'
#   And response params contain 'original_filename'
#   And response params contain 'original_size'
#   And response params contain 'original_mimetype'
#   And response params contain 'thumbnail_url'
#   And response params contain 'downloads_count'
#   And response params contain 'revision_user'
#   And response contains '12' params
#     # delete collection
# Given set request header token from global param 'admin_token' 
#   And set request path param 'collection_id' from global param 'collection_id'
#  When send 'DELETE' request to url 'collection/:collection_id'
#  Then response code is '200'
#   And response params contain 'collection_id'

@revision @select
Scenario: Select revision when user is admin
    # select revision
Given set request header token from global param 'admin_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'mediafile_id'
  And response params contain 'revision_size'
  And response params contain 'original_filename'
  And response params contain 'original_size'
  And response params contain 'original_mimetype'
  And response params contain 'thumbnail_url'
  And response params contain 'downloads_count'
  And response params contain 'revision_user'
  And response contains '11' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@revision @select
Scenario: Select revision when user is editor
    # select revision
Given set request header token from global param 'editor_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'mediafile_id'
  And response params contain 'revision_size'
  And response params contain 'original_filename'
  And response params contain 'original_size'
  And response params contain 'original_mimetype'
  And response params contain 'thumbnail_url'
  And response params contain 'downloads_count'
  And response params contain 'revision_user'
  And response contains '11' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@revision @select
Scenario: Select revision when user is writer
    # select revision
Given set request header token from global param 'writer_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'mediafile_id'
  And response params contain 'revision_size'
  And response params contain 'original_filename'
  And response params contain 'original_size'
  And response params contain 'original_mimetype'
  And response params contain 'thumbnail_url'
  And response params contain 'downloads_count'
  And response params contain 'revision_user'
  And response contains '11' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@revision @select
Scenario: Select revision when user is reader
    # select revision
Given set request header token from global param 'reader_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'mediafile_id'
  And response params contain 'revision_size'
  And response params contain 'original_filename'
  And response params contain 'original_size'
  And response params contain 'original_mimetype'
  And response params contain 'thumbnail_url'
  And response params contain 'downloads_count'
  And response params contain 'revision_user'
  And response contains '11' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@revision @select
Scenario: Select revision when token is missing
    # select revision
Given delete request header token
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id'
 Then response code is '403'
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params
