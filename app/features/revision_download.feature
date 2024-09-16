Feature: Download revision

Background: Authorize users, create collection and document
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # insert collection
Given set request token from global param 'admin_token' 
  And set request param 'is_locked' from value '0'
  And set request param 'collection_name' from fake 'collection_name'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And save response param 'collection_id' to global param 'collection_id'
    # insert document
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'revision_id'
  And save response param 'revision_id' to global param 'revision_id'

@revision @download
Scenario Outline: Download revision when revision_id is not found
Given set request token from global param 'admin_token' 
  And set request placeholder 'revision_id' from value '<revision_id>'
 When send 'GET' request to url 'revision/:revision_id/download'
 Then response code is '404'
  And error loc is 'revision_id'
  And error type is 'resource_not_found'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

Examples:
| revision_id |
| -1          |
| 0           |
| 9999999999  |

@revision @download
Scenario: Download revision when app is locked
    # lock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
    # download revision
Given set request token from global param 'admin_token' 
  And set request placeholder 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'revision/:revision_id/download'
 Then response code is '503'
    # unlock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/unlock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
    # download revision
Given set request token from global param 'admin_token' 
  And set request placeholder 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@revision @download
Scenario: Download revision when user is admin
Given set request token from global param 'admin_token' 
  And set request placeholder 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@revision @download
Scenario: Download revision when user is editor
Given set request token from global param 'editor_token' 
  And set request placeholder 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@revision @download
Scenario: Download revision when user is writer
Given set request token from global param 'writer_token' 
  And set request placeholder 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@revision @download
Scenario: Download revision when user is reader
Given set request token from global param 'reader_token' 
  And set request placeholder 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'revision/:revision_id/download'
 Then response code is '200'
  And response content is not empty
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@revision @download
Scenario: Download revision when token is missing
Given delete request token
  And set request placeholder 'revision_id' from global param 'revision_id'
 When send 'GET' request to url 'revision/:revision_id/download'
 Then response code is '403'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
