Feature: Download upload

Background: Authorize users, create collection and document
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

@upload @download
Scenario Outline: Download upload when upload_id is not found
    # download upload
Given set request header token from global param 'admin_token' 
  And set request path param 'upload_id' from value '<upload_id>'
 When send 'GET' request to url 'upload/:upload_id/download'
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

# @upload @download
# Scenario: Download upload when app is locked
#     # lock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/lock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'True'
#     # download upload
# Given set request header token from global param 'admin_token' 
#   And set request path param 'upload_id' from global param 'upload_id'
#  When send 'GET' request to url 'upload/:upload_id/download'
#  Then response code is '503'
#     # unlock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/unlock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'False'
#     # download upload
# Given set request header token from global param 'admin_token' 
#   And set request path param 'upload_id' from global param 'upload_id'
#  When send 'GET' request to url 'upload/:upload_id/download'
#  Then response code is '200'
#   And response content is not empty
#     # delete document
# Given set request header token from global param 'admin_token' 
#   And set request path param 'document_id' from global param 'document_id'
#  When send 'DELETE' request to url 'document/:document_id'
#  Then response code is '200'
#   And response params contain 'document_id'
#   And response contains '1' params

@upload @download
Scenario: Download upload when user is admin
    # download upload
Given set request header token from global param 'admin_token' 
  And set request path param 'upload_id' from global param 'upload_id'
 When send 'GET' request to url 'upload/:upload_id/download'
 Then response code is '200'
  And response content is not empty
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@upload @download
Scenario: Download upload when user is editor
    # download upload
Given set request header token from global param 'editor_token' 
  And set request path param 'upload_id' from global param 'upload_id'
 When send 'GET' request to url 'upload/:upload_id/download'
 Then response code is '200'
  And response content is not empty
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@upload @download
Scenario: Download upload when user is writer
    # download upload
Given set request header token from global param 'writer_token' 
  And set request path param 'upload_id' from global param 'upload_id'
 When send 'GET' request to url 'upload/:upload_id/download'
 Then response code is '200'
  And response content is not empty
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@upload @download
Scenario: Download upload when user is reader
    # download upload
Given set request header token from global param 'reader_token' 
  And set request path param 'upload_id' from global param 'upload_id'
 When send 'GET' request to url 'upload/:upload_id/download'
 Then response code is '200'
  And response content is not empty
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@upload @download
Scenario: Download upload when token is missing
    # download upload
Given delete request header token
  And set request path param 'upload_id' from global param 'upload_id'
 When send 'GET' request to url 'upload/:upload_id/download'
 Then response code is '403'
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params
