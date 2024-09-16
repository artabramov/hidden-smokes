Feature: Insert comment

Background: Authorize users
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
  And response params contain 'document_id'
  And save response param 'document_id' to global param 'document_id'

@comment @insert
Scenario Outline: Insert comment when document_id not found
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from value '<document_id>'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '404'
  And error loc is 'document_id'
  And error type is 'resource_not_found'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

Examples:
| document_id |
| 0           |
| -1          |
| 9999999999  |

@comment @insert
Scenario Outline: Insert comment when document_id is invalid
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from value '<document_id>'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '422'
  And error loc is 'document_id'
  And error type is '<error_type>'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

Examples:
| document_id | error_type  |
| none        | missing     |
| tabs        | int_parsing |
| spaces      | int_parsing |
| string(0)   | int_parsing |
| string(1)   | int_parsing |
| 123.5       | int_parsing |
| 123,0       | int_parsing |

@comment @insert
Scenario Outline: Insert comment when comment_content is invalid
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from value '<comment_content>'
 When send 'POST' request to url 'comment'
 Then response code is '422'
  And error loc is 'comment_content'
  And error type is '<error_type>'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

Examples:
| comment_content | error_type       |
| none            | missing          |
| tabs            | string_too_short |
| spaces          | string_too_short |
| string(0)       | string_too_short |
| string(513)     | string_too_long  |

@comment @insert
Scenario Outline: Insert comment when comment_content is correct
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from value '<comment_content>'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

Examples:
| comment_content |
| string(1)       |
| string(512)     |

@comment @insert
Scenario: Insert comment when collection is locked
    # lock collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
  And set request param 'is_locked' from value '1'
  And set request param 'collection_name' from fake 'collection_name'
 When send 'PUT' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
    # insert comment
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '423'
  And error loc is 'document_id'
  And error type is 'resource_locked'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @insert
Scenario: Insert comment when app is locked
    # lock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'service/lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
    # insert comment
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '503'
    # unlock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'service/unlock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
    # insert comment
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @insert
Scenario: Insert comment when user is admin
Given set request token from global param 'admin_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @insert
Scenario: Insert comment when user is editor
Given set request token from global param 'editor_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @insert
Scenario: Insert comment when user is writer
Given set request token from global param 'writer_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '201'
  And response params contain 'comment_id'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @insert
Scenario: Insert comment when user is reader
Given set request token from global param 'reader_token' 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@comment @insert
Scenario: Insert comment when token is missing
Given delete request token 
  And set request param 'document_id' from global param 'document_id'
  And set request param 'comment_content' from fake 'comment_content'
 When send 'POST' request to url 'comment'
 Then response code is '403'
    # delete collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
