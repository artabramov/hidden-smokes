Feature: Insert document

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

@document @insert
Scenario Outline: Insert document when collection_id not found
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from value '<collection_id>'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '404'
  And error loc is 'collection_id'
  And error type is 'resource_not_found'

Examples:
| collection_id |
| 0             |
| -1            |
| 9999999999    |

@document @insert
Scenario Outline: Insert document when collection_id is invalid
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from value '<collection_id>'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '422'
  And error loc is 'collection_id'
  And error type is '<error_type>'

Examples:
| collection_id | error_type  |
| none          | missing     |
| tabs          | int_parsing |
| spaces        | int_parsing |
| string(0)     | int_parsing |
| string(1)     | int_parsing |
| 123.5         | int_parsing |
| 123,0         | int_parsing |

@document @insert
Scenario Outline: Insert document when document_name is invalid
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from value '<document_name>'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '422'
  And error loc is 'document_name'
  And error type is '<error_type>'

Examples:
| document_name | error_type      |
| string(257)   | string_too_long |

@document @insert
Scenario Outline: Insert document when document_name is correct or missing
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from value '<document_name>'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'

Examples:
| document_name |
| none          |
| tabs          |
| spaces        |
| string(0)     |
| string(1)     |
| string(256)   |

@document @insert
Scenario Outline: Insert document when document_summary is invalid
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from value '<document_summary>'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '422'
  And error loc is 'document_summary'
  And error type is '<error_type>'

Examples:
| document_summary | error_type      |
| string(513)      | string_too_long |

@document @insert
Scenario Outline: Insert document when document_summary is correct
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from value '<document_summary>'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'

Examples:
| document_summary |
| none             |
| tabs             |
| spaces           |
| string(0)        |
| string(1)        |
| string(512)      |

@document @insert
Scenario: Insert document when collection is locked
    # lock collection
Given set request token from global param 'admin_token' 
  And set request placeholder 'collection_id' from global param 'collection_id'
  And set request param 'is_locked' from value '1'
  And set request param 'collection_name' from fake 'collection_name'
  And set request param 'collection_summary' from fake 'collection_summary'
 When send 'PUT' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
    # insert document
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '423'
  And error loc is 'collection_id'
  And error type is 'resource_locked'

@document @insert
Scenario: Insert document when user is admin
Given set request token from global param 'admin_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'

@document @insert
Scenario: Insert document when user is editor
Given set request token from global param 'editor_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'

@document @insert
Scenario: Insert document when user is writer
Given set request token from global param 'writer_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'

@document @insert
Scenario: Insert document when user is reader
Given set request token from global param 'reader_token' 
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@document @insert
Scenario: Insert document when token is missing
Given delete request token
  And set request param 'collection_id' from global param 'collection_id'
  And set request param 'document_name' from fake 'document_name'
  And set request param 'document_summary' from fake 'document_summary'
  And set request param 'tags' from fake 'document_tags'
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '403'
