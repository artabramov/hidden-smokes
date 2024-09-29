Feature: Download mediafile

Background: Auth users, upload and replace mediafile
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
    # replace mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile/:mediafile_id'
 Then response code is '201'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params

@mediafile @download
Scenario Outline: Download mediafile when mediafile_id is not found
    # download mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from value '<mediafile_id>'
 When send 'GET' request to url 'mediafile/:mediafile_id/download'
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

@mediafile @download
Scenario: Download revision when app is locked
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # download mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/download'
 Then response code is '423'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # download mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/download'
 Then response code is '200'
  And response content is not empty
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @download
Scenario: Download mediafile when user is admin
    # download mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/download'
 Then response code is '200'
  And response content is not empty
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @download
Scenario: Download mediafile when user is editor
    # download mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/download'
 Then response code is '200'
  And response content is not empty
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @download
Scenario: Download mediafile when user is writer
    # download mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/download'
 Then response code is '200'
  And response content is not empty
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @download
Scenario: Download mediafile when user is reader
    # download mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/download'
 Then response code is '200'
  And response content is not empty
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @download
Scenario: Download mediafile when token is missing
    # download mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/download'
 Then response code is '200'
  And response content is not empty
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params
