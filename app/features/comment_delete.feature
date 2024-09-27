Feature: Delete comment

Background: Auth users, upload document and insert comment
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
  And response params contain 'revision_id'
  And response contains '2' params
  And save response param 'document_id' to global param 'document_id'
    # remove file from request
Given delete request file

@comment @delete
Scenario Outline: Delete comment when comment_id not found
Given set request header token from global param 'admin_token' 
  And set request path param 'comment_id' from value '<comment_id>'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '404'
  And error loc is 'path' and 'comment_id'
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
| comment_id |
| -1         |
| 0          |
| 9999999999 |

# @comment @delete
# Scenario: Delete comment when collection is locked
#     # insert comment
# Given set request header token from global param 'admin_token' 
#   And set request body param 'document_id' from global param 'document_id'
#   And set request body param 'comment_content' from fake 'comment_content'
#  When send 'POST' request to url 'comment'
#  Then response code is '201'
#   And response params contain 'comment_id'
#   And save response param 'comment_id' to global param 'comment_id'
#     # lock collection
# Given set request header token from global param 'admin_token' 
#   And set request path param 'collection_id' from global param 'collection_id'
#   And set request body param 'is_locked' from value '1'
#   And set request body param 'collection_name' from fake 'collection_name'
#  When send 'PUT' request to url 'collection/:collection_id'
#  Then response code is '200'
#   And response params contain 'collection_id'
#     # delete comment
# Given set request header token from global param 'admin_token' 
#   And set request path param 'comment_id' from global param 'comment_id'
#   And set request body param 'comment_content' from fake 'comment_content'
#  When send 'DELETE' request to url 'comment/:comment_id'
#  Then response code is '423'
#   And error loc is 'comment_id'
#   And error type is 'resource_locked'
#     # delete document
# Given set request header token from global param 'admin_token' 
#   And set request path param 'document_id' from global param 'document_id'
#  When send 'DELETE' request to url 'document/:document_id'
#  Then response code is '200'
#   And response params contain 'document_id'
#   And response contains '1' params

# @comment @delete
# Scenario: Delete comment when app is locked
#     # insert comment
# Given set request header token from global param 'admin_token' 
#   And set request body param 'document_id' from global param 'document_id'
#   And set request body param 'comment_content' from fake 'comment_content'
#  When send 'POST' request to url 'comment'
#  Then response code is '201'
#   And response params contain 'comment_id'
#   And save response param 'comment_id' to global param 'comment_id'
#     # lock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/lock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'True'
#     # delete comment
# Given set request header token from global param 'admin_token' 
#   And set request path param 'comment_id' from global param 'comment_id'
#   And set request body param 'comment_content' from fake 'comment_content'
#  When send 'DELETE' request to url 'comment/:comment_id'
#  Then response code is '503'
#     # unlock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/unlock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'False'
#     # delete comment
# Given set request header token from global param 'admin_token' 
#   And set request path param 'comment_id' from global param 'comment_id'
#   And set request body param 'comment_content' from fake 'comment_content'
#  When send 'DELETE' request to url 'comment/:comment_id'
#  Then response code is '200'
#   And response params contain 'comment_id'
#     # delete collection
# Given set request header token from global param 'admin_token' 
#   And set request path param 'collection_id' from global param 'collection_id'
#  When send 'DELETE' request to url 'collection/:collection_id'
#  Then response code is '200'
#   And response params contain 'collection_id'

@comment @delete
Scenario: Delete comment when user is admin
    # insert comment
Given set request header token from global param 'admin_token' 
  And set request body param 'document_id' from global param 'document_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
  And response contains '1' params
    # delete comment
Given set request header token from global param 'admin_token' 
  And set request path param 'comment_id' from global param 'comment_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'comment_id'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@comment @delete
Scenario: Delete comment when user is editor
    # insert comment
Given set request header token from global param 'editor_token' 
  And set request body param 'document_id' from global param 'document_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
    # delete comment
Given set request header token from global param 'editor_token' 
  And set request path param 'comment_id' from global param 'comment_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '200'
  And response params contain 'comment_id'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@comment @delete
Scenario: Delete comment when user is writer
    # insert comment
Given set request header token from global param 'writer_token' 
  And set request body param 'document_id' from global param 'document_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
    # delete comment
Given set request header token from global param 'writer_token' 
  And set request path param 'comment_id' from global param 'comment_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@comment @delete
Scenario: Delete comment when user is writer-to-reader
    # insert comment
Given set request header token from global param 'writer_token' 
  And set request body param 'document_id' from global param 'document_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
    # delete comment
Given set request header token from global param 'reader_token' 
  And set request path param 'comment_id' from global param 'comment_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@comment @delete
Scenario: Delete comment when user is writer-to-admin
    # insert comment
Given set request header token from global param 'writer_token' 
  And set request body param 'document_id' from global param 'document_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
    # delete comment
Given set request header token from global param 'admin_token' 
  And set request path param 'comment_id' from global param 'comment_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '403'
  And error loc is 'path' and 'comment_id'
  And error type is 'resource_forbidden'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@comment @delete
Scenario: Delete comment when token is missing
    # insert comment
Given set request header token from global param 'writer_token' 
  And set request body param 'document_id' from global param 'document_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And save response param 'comment_id' to global param 'comment_id'
  And response contains '1' params
    # delete comment
Given delete request header token 
  And set request path param 'comment_id' from global param 'comment_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'DELETE' request to url 'comment/:comment_id'
 Then response code is '403'
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params
