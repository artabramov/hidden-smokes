Feature: Insert mediafile

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

# @mediafile @upload
# Scenario: Insert mediafile when app is locked
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

@mediafile @upload
Scenario: Insert mediafile when user is admin
    # upload mediafile
Given set request header token from global param 'admin_token' 
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile'
 Then response code is '201'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
  And save response param 'mediafile_id' to global param 'mediafile_id'
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @upload
Scenario: Insert mediafile when user is editor
    # upload mediafile
Given set request header token from global param 'editor_token' 
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile'
 Then response code is '201'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
  And save response param 'mediafile_id' to global param 'mediafile_id'
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @upload
Scenario: Insert mediafile when user is writer
    # upload mediafile
Given set request header token from global param 'writer_token' 
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile'
 Then response code is '201'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
  And save response param 'mediafile_id' to global param 'mediafile_id'
    # delete mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
 When send 'DELETE' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response contains '1' params

@mediafile @upload
Scenario: Insert mediafile when user is reader
    # upload mediafile
Given set request header token from global param 'reader_token' 
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params

@mediafile @upload
Scenario: Insert mediafile when token is missing
    # upload mediafile
Given delete request header token
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'mediafile'
 Then response code is '403'
