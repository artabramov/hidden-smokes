Feature: Download revision

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

@revision @download
Scenario Outline: Download revision when revision_id is incorrect
    # download revision
Given set request header token from global param 'admin_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from value '<revision_id>'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id/download'
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

@revision @download
Scenario Outline: Download revision when mediafile_id is incorrect
    # download revision
Given set request header token from global param 'admin_token'
  And set request path param 'mediafile_id' from value '<mediafile_id>'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id/download'
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

@revision @download
Scenario: Download revision when app is locked
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # download revision
Given set request header token from global param 'admin_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id/download'
 Then response code is '423'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # download revision
Given set request header token from global param 'admin_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@revision @download
Scenario: Download revision when user is admin
    # download revision
Given set request header token from global param 'admin_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@revision @download
Scenario: Download revision when user is editor
    # download revision
Given set request header token from global param 'editor_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@revision @download
Scenario: Download revision when user is writer
    # download revision
Given set request header token from global param 'writer_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@revision @download
Scenario: Download revision when user is reader
    # download revision
Given set request header token from global param 'reader_token'
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@revision @download
Scenario: Download revision when token is missing
    # download revision
Given delete request header token
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request path param 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'mediafile/:mediafile_id/revision/:revision_id/download'
 Then response code is '403'
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params
