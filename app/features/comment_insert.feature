Feature: Insert comment

Background: Auth users, create collection and upload datafile
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # upload datafile
Given set request header token from global param 'admin_token' 
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'datafile'
 Then response code is '201'
  And response params contain 'datafile_id'
  And response params contain 'revision_id'
  And response contains '2' params
  And save response param 'datafile_id' to global param 'datafile_id'
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
    # relate datafile to collection
Given set request header token from global param 'admin_token' 
  And set request path param 'datafile_id' from global param 'datafile_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'datafile_name' from fake 'datafile_name'
 When send 'PUT' request to url 'datafile/:datafile_id'
 Then response code is '200'
  And response params contain 'datafile_id'
  And response params contain 'revision_id'
  And response contains '2' params

@comment @insert
Scenario Outline: Insert comment when datafile_id not found
    # insert comment
Given set request header token from global param 'admin_token' 
  And set request body param 'datafile_id' from value '<datafile_id>'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '404'
  And error loc is 'body' and 'datafile_id'
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
| datafile_id |
| 0           |
| -1          |
| 9999999999  |

@comment @insert
Scenario Outline: Insert comment when datafile_id is invalid
    # insert comment
Given set request header token from global param 'admin_token' 
  And set request body param 'datafile_id' from value '<datafile_id>'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '422'
  And error loc is 'body' and 'datafile_id'
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
| datafile_id | error_type  |
| none        | missing     |
| tabs        | int_parsing |
| spaces      | int_parsing |
| string(0)   | int_parsing |
| string(1)   | int_parsing |
| 123.5       | int_parsing |
| 123,0       | int_parsing |

@comment @insert
Scenario Outline: Insert comment when comment_content is invalid
    # insert comment
Given set request header token from global param 'admin_token' 
  And set request body param 'datafile_id' from global param 'datafile_id'
  And set request body param 'comment_content' from value '<comment_content>'
 When send 'POST' request to url 'comment'
 Then response code is '422'
  And error loc is 'body' and 'comment_content'
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
| comment_content | error_type       |
| none            | missing          |
| tabs            | string_too_short |
| spaces          | string_too_short |
| string(0)       | string_type      |
| string(513)     | string_too_long  |

@comment @insert
Scenario Outline: Insert comment when comment_content is correct
    # insert comment
Given set request header token from global param 'admin_token' 
  And set request body param 'datafile_id' from global param 'datafile_id'
  And set request body param 'comment_content' from value '<comment_content>'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

Examples:
| comment_content |
| string(1)       |
| string(512)     |

@comment @insert
Scenario: Insert comment when collection is locked
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
    # insert comment
Given set request header token from global param 'admin_token' 
  And set request body param 'datafile_id' from global param 'datafile_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '423'
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
    # insert comment
Given set request header token from global param 'admin_token' 
  And set request body param 'datafile_id' from global param 'datafile_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@comment @insert
Scenario: Insert comment when app is locked
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # insert comment
Given set request header token from global param 'admin_token' 
  And set request body param 'datafile_id' from global param 'datafile_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '423'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # insert comment
Given set request header token from global param 'admin_token' 
  And set request body param 'datafile_id' from global param 'datafile_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@comment @insert
Scenario: Insert comment when user is admin
    # insert comment
Given set request header token from global param 'admin_token' 
  And set request body param 'datafile_id' from global param 'datafile_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@comment @insert
Scenario: Insert comment when user is editor
    # insert comment
Given set request header token from global param 'editor_token' 
  And set request body param 'datafile_id' from global param 'datafile_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@comment @insert
Scenario: Insert comment when user is writer
    # insert comment
Given set request header token from global param 'writer_token' 
  And set request body param 'datafile_id' from global param 'datafile_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@comment @insert
Scenario: Insert comment when user is reader
    # insert comment
Given set request header token from global param 'reader_token' 
  And set request body param 'datafile_id' from global param 'datafile_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
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

@comment @insert
Scenario: Insert comment when token is missing
    # insert comment
Given delete request header token 
  And set request body param 'datafile_id' from global param 'datafile_id'
  And set request body param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '403'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params
