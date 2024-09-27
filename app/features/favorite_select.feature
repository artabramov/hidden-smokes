Feature: Select favorite

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
  And response params contain 'revision_id'
  And response contains '2' params
  And save response param 'document_id' to global param 'document_id'
    # remove file from request
Given delete request file

@favorite @select
Scenario Outline: Select favorite when favorite_id is not found
    # insert favorite
Given set request header token from global param 'admin_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And response contains '1' params
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given set request header token from global param 'admin_token' 
  And set request path param 'favorite_id' from value '<favorite_id>'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '404'
  And error loc is 'path' and 'favorite_id'
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
| favorite_id |
| -1          |
| 0           |
| 9999999999  |

# @favorite @select
# Scenario: Select favorite when app is locked
#     # insert favorite
# Given set request header token from global param 'admin_token' 
#   And set request param 'document_id' from global param 'document_id'
#  When send 'POST' request to url 'favorite'
#  Then response code is '201'
#   And response params contain 'favorite_id'
#   And save response param 'favorite_id' to global param 'favorite_id'
#     # lock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/lock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'True'
#     # select favorite
# Given set request header token from global param 'admin_token' 
#   And set request path param 'favorite_id' from global param 'favorite_id'
#  When send 'GET' request to url 'favorite/:favorite_id'
#  Then response code is '503'
#     # unlock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/unlock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'False'
#     # select favorite
# Given set request header token from global param 'admin_token' 
#   And set request path param 'favorite_id' from global param 'favorite_id'
#  When send 'GET' request to url 'favorite/:favorite_id'
#  Then response code is '200'
#   And response params contain 'id'
#   And response params contain 'created_date'
#   And response params contain 'user_id'
#   And response params contain 'document_id'
#   And response params contain 'favorite_document'
#   And response contains '5' params
#     # delete document
# Given set request header token from global param 'admin_token' 
#   And set request path param 'document_id' from global param 'document_id'
#  When send 'DELETE' request to url 'document/:document_id'
#  Then response code is '200'
#   And response params contain 'document_id'
#   And response contains '1' params

@favorite @select
Scenario: Select favorite when user is admin
    # insert favorite
Given set request header token from global param 'admin_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And response contains '1' params
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given set request header token from global param 'admin_token' 
  And set request path param 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'favorite_document'
  And response contains '5' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@favorite @select
Scenario: Select favorite when user is admin-to-reader
    # insert favorite
Given set request header token from global param 'reader_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And response contains '1' params
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given set request header token from global param 'admin_token' 
  And set request path param 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '403'
  And error loc is 'path' and 'favorite_id'
  And error type is 'resource_forbidden'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@favorite @select
Scenario: Select favorite when user is editor
    # insert favorite
Given set request header token from global param 'editor_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And response contains '1' params
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given set request header token from global param 'editor_token' 
  And set request path param 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'favorite_document'
  And response contains '5' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@favorite @select
Scenario: Select favorite when user is writer
    # insert favorite
Given set request header token from global param 'writer_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And response contains '1' params
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given set request header token from global param 'writer_token' 
  And set request path param 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'favorite_document'
  And response contains '5' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@favorite @select
Scenario: Select favorite when user is reader
    # insert favorite
Given set request header token from global param 'reader_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And response contains '1' params
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given set request header token from global param 'reader_token' 
  And set request path param 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'user_id'
  And response params contain 'document_id'
  And response params contain 'favorite_document'
  And response contains '5' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@favorite @select
Scenario: Select favorite when token is missing
    # insert favorite
Given set request header token from global param 'admin_token' 
  And set request body param 'document_id' from global param 'document_id'
 When send 'POST' request to url 'favorite'
 Then response code is '201'
  And response params contain 'favorite_id'
  And response contains '1' params
  And save response param 'favorite_id' to global param 'favorite_id'
    # select favorite
Given delete request header token 
  And set request path param 'favorite_id' from global param 'favorite_id'
 When send 'GET' request to url 'favorite/:favorite_id'
 Then response code is '403'
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params
