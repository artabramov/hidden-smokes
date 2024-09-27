Feature: Select comment

Background: Auth users, upload mediafile and insert comment
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
    # insert comment
Given set request header token from global param 'admin_token' 
  And set request body param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And response contains '1' params
  And save response param 'comment_id' to global param 'comment_id'

@comment @select
Scenario Outline: Select comment when mediafile_id not found
Given set request header token from global param 'admin_token' 
  And set request path param 'comment_id' from value '<comment_id>'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '404'
  And error loc is 'path' and 'comment_id'
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
| comment_id |
| -1         |
| 0          |
| 9999999999 |

# @comment @select
# Scenario: Select comment when app is locked
#     # lock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/lock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'True'
#     # select comment
# Given set request header token from global param 'admin_token' 
#   And set request path param 'comment_id' from global param 'comment_id'
#  When send 'GET' request to url 'comment/:comment_id'
#  Then response code is '503'
#     # unlock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/unlock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'False'
#     # select comment
# Given set request header token from global param 'admin_token' 
#   And set request path param 'comment_id' from global param 'comment_id'
#  When send 'GET' request to url 'comment/:comment_id'
#  Then response code is '200'
#   And response params contain 'id'
#   And response params contain 'created_date'
#   And response params contain 'updated_date'
#   And response params contain 'user_id'
#   And response params contain 'mediafile_id'
#   And response params contain 'comment_content'
#   And response params contain 'comment_user'
#   And response contains '7' params
#     # delete mediafile
# Given set request header token from global param 'admin_token' 
#   And set request path param 'mediafile_id' from global param 'mediafile_id'
#  When send 'DELETE' request to url 'mediafile/:mediafile_id'
#  Then response code is '200'
#   And response params contain 'mediafile_id'
#   And response contains '1' params

@comment @select
Scenario: Select comment when user is admin
Given set request header token from global param 'admin_token' 
  And set request path param 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'mediafile_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
  And response contains '7' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@comment @select
Scenario: Select comment when user is editor
Given set request header token from global param 'editor_token' 
  And set request path param 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'mediafile_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
  And response contains '7' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@comment @select
Scenario: Select comment when user is writer
Given set request header token from global param 'writer_token' 
  And set request path param 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'mediafile_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
  And response contains '7' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@comment @select
Scenario: Select comment when user is reader
Given set request header token from global param 'reader_token' 
  And set request path param 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'user_id'
  And response params contain 'mediafile_id'
  And response params contain 'comment_content'
  And response params contain 'comment_user'
  And response contains '7' params
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@comment @select
Scenario: Select comment when token is missing
Given delete request header token 
  And set request path param 'comment_id' from global param 'comment_id'
 When send 'GET' request to url 'comment/:comment_id'
 Then response code is '403'
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params
