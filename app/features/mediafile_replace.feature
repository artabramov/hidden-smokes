Feature: Replace mediafile

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

@mediafile @replace
Scenario Outline: Replace mediafile when mediafile_id not found
    # replace mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from value '<mediafile_id>'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile/:mediafile_id'
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
    # remove file from request
Given delete request file

Examples:
| mediafile_id |
| 0           |
| -1          |
| 9999999999  |

@mediafile @replace
Scenario Outline: Replace mediafile when mediafile_id is invalid
    # replace mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from value '<mediafile_id>'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile/:mediafile_id'
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

# @mediafile @replace
# Scenario: Replace mediafile when collection is locked
#     # lock collection
# Given set request header token from global param 'admin_token' 
#   And set request path param 'collection_id' from global param 'collection_id'
#   And set request body param 'is_locked' from value '1'
#   And set request body param 'collection_name' from fake 'collection_name'
#  When send 'PUT' request to url 'collection/:collection_id'
#  Then response code is '200'
#   And response params contain 'collection_id'
#   And response contains '1' params
#     # replace mediafile
# Given set request header token from global param 'admin_token' 
#   And set request path param 'mediafile_id' from value '<mediafile_id>'
#   And set request file from sample format 'pdf'
#  When send 'POST' request to url 'mediafile/:mediafile_id'
#  Then response code is '423'
#   And error loc is 'path' and 'collection_id'
#   And error type is 'resource_locked'
#   And response contains '1' params
#     # delete mediafile
# Given set request header token from global param 'admin_token' 
#   And set request path param 'mediafile_id' from global param 'mediafile_id'
#  When send 'DELETE' request to url 'mediafile/:mediafile_id'
#  Then response code is '200'
#   And response params contain 'mediafile_id'
#   And response contains '1' params

# @mediafile @replace
# Scenario: Replace mediafile when app is locked
#     # lock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/lock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'True'
#     # upload mediafile
# Given set request header token from global param 'admin_token' 
#   And set request path param 'collection_id' from global param 'collection_id'
#  When send 'POST' request to url 'mediafile'
#  Then response code is '503'
#     # unlock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/unlock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'False'
#     # upload mediafile
# Given set request header token from global param 'admin_token' 
#   And set request body param 'collection_id' from global param 'collection_id'
#   And set request body param 'mediafile_name' from fake 'mediafile_name'
#   And set request body param 'mediafile_summary' from fake 'mediafile_summary'
#   And set request body param 'tags' from fake 'mediafile_tags'
#  When send 'POST' request to url 'mediafile'
#  Then response code is '201'
#   And response params contain 'mediafile_id'
#   And response contains '1' params
#     # delete collection
# Given set request header token from global param 'admin_token' 
#   And set request path param 'collection_id' from global param 'collection_id'
#  When send 'DELETE' request to url 'collection/:collection_id'
#  Then response code is '200'
#   And response params contain 'collection_id'

@mediafile @replace
Scenario: Replace mediafile when user is admin
    # replace mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile/:mediafile_id'
 Then response code is '201'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @replace
Scenario: Replace mediafile when user is editor
    # replace mediafile
Given set request header token from global param 'editor_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile/:mediafile_id'
 Then response code is '201'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @replace
Scenario: Replace mediafile when user is writer
    # replace mediafile
Given set request header token from global param 'writer_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile/:mediafile_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @replace
Scenario: Replace mediafile when user is reader
    # replace mediafile
Given set request header token from global param 'reader_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile/:mediafile_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @replace
Scenario: Replace mediafile when token is missing
    # replace mediafile
Given delete request header token 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile/:mediafile_id'
 Then response code is '403'
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params
