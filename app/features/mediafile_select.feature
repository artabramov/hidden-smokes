Feature: Select mediafile

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
    # remove file from request
Given delete request file

@mediafile @select
Scenario Outline: Select mediafile when mediafile_id not found
    # select mediafile
Given set request header token from global param 'reader_token'
  And set request path param 'mediafile_id' from value '<mediafile_id>'
 When send 'GET' request to url 'mediafile/:mediafile_id'
 Then response code is '404'
  And error loc is 'path' and 'mediafile_id'
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

@mediafile @select
Scenario Outline: Select mediafile when mediafile_id is invalid
    # select mediafile
Given set request header token from global param 'reader_token'
  And set request path param 'mediafile_id' from value '<mediafile_id>'
 When send 'GET' request to url 'mediafile/:mediafile_id'
 Then response code is '422'
  And error loc is 'path' and 'mediafile_id'
  And error type is '<error_type>'
  And response contains '1' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

Examples:
| mediafile_id | error_type  |
| tabs        | int_parsing |
| spaces      | int_parsing |
| string(1)   | int_parsing |
| 123.5       | int_parsing |
| 123,0       | int_parsing |

# @mediafile @select
# Scenario: Select mediafile when collection is locked
#     # lock collection
# Given set request header token from global param 'admin_token' 
#   And set request path param 'collection_id' from global param 'collection_id'
#   And set request body param 'is_locked' from value '1'
#   And set request body param 'collection_name' from fake 'collection_name'
#  When send 'PUT' request to url 'collection/:collection_id'
#  Then response code is '200'
#   And response params contain 'collection_id'
#   And response contains '1' params
#     # select mediafile
# Given set request header token from global param 'reader_token' 
#   And set request path param 'collection_id' from global param 'collection_id'
#   And set request path param 'mediafile_id' from global param 'mediafile_id'
#  When send 'GET' request to url 'collection/:collection_id/mediafile/:mediafile_id'
#  Then response code is '200'
#   And response params contain 'id'
#   And response params contain 'created_date'
#   And response params contain 'updated_date'
#   And response params contain 'user_id'
#   And response params contain 'collection_id'
#   And response params contain 'mediafile_summary'
#   And response params contain 'comments_count'
#   And response params contain 'revisions_count'
#   And response params contain 'revisions_size'
#   And response params contain 'downloads_count'
#   And response params contain 'downloads_size'
#   And response params contain 'mediafile_tags'
#   And response params contain 'mediafile_user'
#   And response params contain 'latest_revision'
#   And response contains '14' params
#     # delete mediafile
# Given set request header token from global param 'admin_token' 
#   And set request path param 'mediafile_id' from global param 'mediafile_id'
#  When send 'DELETE' request to url 'mediafile/:mediafile_id'
#  Then response code is '200'
#   And response params contain 'mediafile_id'
#   And response contains '1' params

# @mediafile @select
# Scenario: Select mediafile when app is locked
#     # lock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/lock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'True'
#     # select mediafile
# Given set request header token from global param 'admin_token' 
#   And set request path param 'mediafile_id' from global param 'mediafile_id'
#  When send 'GET' request to url 'mediafile/:mediafile_id'
#  Then response code is '503'
#     # unlock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/unlock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'False'
#     # select mediafile
# Given set request header token from global param 'admin_token' 
#   And set request path param 'mediafile_id' from global param 'mediafile_id'
#  When send 'GET' request to url 'mediafile/:mediafile_id'
#  Then response code is '200'
#   And response params contain 'id'
#   And response params contain 'created_date'
#   And response params contain 'updated_date'
#   And response params contain 'user_id'
#   And response params contain 'collection_id'
#   And response params contain 'mediafile_name'
#   And response params contain 'mediafile_summary'
#   And response params contain 'revisions_count'
#   And response params contain 'revisions_size'
#   And response params contain 'comments_count'
#   And response params contain 'downloads_count'
#   And response params contain 'favorites_count'
#   And response params contain 'mediafile_tags'
#   And response params contain 'mediafile_revision'
#   And response contains '14' params
#     # delete collection
# Given set request header token from global param 'admin_token' 
#   And set request path param 'collection_id' from global param 'collection_id'
#  When send 'DELETE' request to url 'collection/:collection_id'
#  Then response code is '200'
#   And response params contain 'collection_id'

@mediafile @select
Scenario: Select mediafile when user is admin
    # select mediafile
Given set request header token from global param 'reader_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'GET' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'collection_id'
  And response params contain 'mediafile_name'
  And response params contain 'mediafile_summary'
  And response params contain 'comments_count'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'downloads_count'
  And response params contain 'downloads_size'
  And response params contain 'mediafile_tags'
  And response params contain 'mediafile_user'
  And response params contain 'latest_revision'
  And response contains '15' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @select
Scenario: Select mediafile when user is editor
    # select mediafile
Given set request header token from global param 'reader_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'GET' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'collection_id'
  And response params contain 'mediafile_name'
  And response params contain 'mediafile_summary'
  And response params contain 'comments_count'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'downloads_count'
  And response params contain 'downloads_size'
  And response params contain 'mediafile_tags'
  And response params contain 'mediafile_user'
  And response params contain 'latest_revision'
  And response contains '15' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @select
Scenario: Select mediafile when user is writer
    # select mediafile
Given set request header token from global param 'reader_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'GET' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'collection_id'
  And response params contain 'mediafile_name'
  And response params contain 'mediafile_summary'
  And response params contain 'comments_count'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'downloads_count'
  And response params contain 'downloads_size'
  And response params contain 'mediafile_tags'
  And response params contain 'mediafile_user'
  And response params contain 'latest_revision'
  And response contains '15' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @select
Scenario: Select mediafile when user is reader
    # select mediafile
Given set request header token from global param 'reader_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'GET' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'collection_id'
  And response params contain 'mediafile_name'
  And response params contain 'mediafile_summary'
  And response params contain 'comments_count'
  And response params contain 'revisions_count'
  And response params contain 'revisions_size'
  And response params contain 'downloads_count'
  And response params contain 'downloads_size'
  And response params contain 'mediafile_tags'
  And response params contain 'mediafile_user'
  And response params contain 'latest_revision'
  And response contains '15' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @select
Scenario: Select mediafile when token is missing
    # select mediafile
Given delete request header token
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'GET' request to url 'mediafile/:mediafile_id'
 Then response code is '403'
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params
