Feature: Update mediafile

Background: Auth users, create collection and upload mediafile
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
    # create collection
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'POST' request to url 'collection'
 Then response code is '201'
  And response params contain 'collection_id'
  And response contains '1' params
  And save response param 'collection_id' to global param 'collection_id'
    # relate mediafile to collection
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params

@mediafile @update
Scenario Outline: Update mediafile when mediafile_id not found
    # update mediafile
Given set request header token from global param 'editor_token' 
  And set request path param 'mediafile_id' from value '<mediafile_id>'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '404'
  And error loc is 'path' and 'mediafile_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

Examples:
| mediafile_id |
| -1          |
| 0           |
| 9999999999  |

@mediafile @update
Scenario Outline: Update mediafile when mediafile_id is invalid
    # update mediafile
Given set request header token from global param 'editor_token' 
  And set request path param 'mediafile_id' from value '<mediafile_id>'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '422'
  And error loc is 'path' and 'mediafile_id'
  And error type is '<error_type>'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

Examples:
| mediafile_id | error_type  |
| tabs        | int_parsing |
| spaces      | int_parsing |
| string(1)   | int_parsing |
| 123.5       | int_parsing |
| 123,0       | int_parsing |

@mediafile @update
Scenario Outline: Update mediafile when mediafile_name is invalid
    # update mediafile
Given set request header token from global param 'editor_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from value '<mediafile_name>'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '422'
  And error loc is 'body' and 'mediafile_name'
  And error type is '<error_type>'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

Examples:
| mediafile_name | error_type       |
| none          | missing          |
| tabs          | string_too_short |
| spaces        | string_too_short |
| string(0)     | string_type      |
| string(257)   | string_too_long  |

@mediafile @update
Scenario Outline: Update mediafile when mediafile_name is correct
    # update mediafile
Given set request header token from global param 'editor_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from value '<mediafile_name>'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

Examples:
| original_filename |
| string(1)         |
| string(256)       |

@mediafile @update
Scenario Outline: Update mediafile when mediafile_summary is invalid
    # update mediafile
Given set request header token from global param 'editor_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from value '<mediafile_summary>'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '422'
  And error loc is 'body' and 'mediafile_summary'
  And error type is '<error_type>'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

Examples:
| mediafile_summary | error_type      |
| string(513)       | string_too_long |

@mediafile @update
Scenario Outline: Update mediafile when mediafile_summary is correct
    # update mediafile
Given set request header token from global param 'editor_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from value '<mediafile_summary>'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

Examples:
| mediafile_summary |
| none              |
| tabs              |
| spaces            |
| string(0)         |
| string(1)         |
| string(512)       |

@mediafile @update
Scenario: Update mediafile when collection is locked
    # lock collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
  And set request body param 'is_locked' from value '1'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'PUT' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params
    # update mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '423'
  And error loc is 'path' and 'mediafile_id'
  And error type is 'resource_locked'
  And response contains '1' params
    # unlock collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
  And set request body param 'is_locked' from value '0'
  And set request body param 'collection_name' from fake 'collection_name'
  And set request body param 'collection_summary' from fake 'collection_summary'
 When send 'PUT' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params
    # update mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@mediafile @update
Scenario: Update mediafile when app is locked
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # update mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '423'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # update mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@mediafile @update
Scenario: Update mediafile when user is admin
    # update mediafile
Given set request header token from global param 'admin_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@mediafile @update
Scenario: Update mediafile when user is editor
    # update mediafile
Given set request header token from global param 'editor_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '200'
  And response params contain 'mediafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@mediafile @update
Scenario: Update mediafile when user is writer
    # update mediafile
Given set request header token from global param 'writer_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@mediafile @update
Scenario: Update mediafile when user is reader
    # update mediafile
Given set request header token from global param 'reader_token' 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_rejected'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@mediafile @update
Scenario: Update mediafile when token is missing
    # update mediafile
Given delete request header token 
  And set request path param 'mediafile_id' from global param 'mediafile_id'
  And set request body param 'mediafile_name' from fake 'mediafile_name'
  And set request body param 'mediafile_summary' from fake 'mediafile_summary'
  And set request body param 'tags' from fake 'mediafile_tags'
 When send 'PUT' request to url 'mediafile/:mediafile_id'
 Then response code is '403'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params
