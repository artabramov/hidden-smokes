Feature: Pin document

Background: Auth users, create collection and upload document
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
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
    # upload document
Given set request header token from global param 'admin_token' 
  And set request file from sample format 'pdf'
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'POST' request to url 'collection/:collection_id/document'
 Then response code is '201'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And response contains '2' params
  And save response param 'document_id' to global param 'document_id'
    # remove file from request
Given delete request file

@document @pin
Scenario Outline: Pin document when document_id not found
    # pin document
Given set request header token from global param 'editor_token'
  And set request path param 'document_id' from value '<document_id>'
  And set request body param 'is_pinned' from value '1'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '404'
  And error loc is 'path' and 'document_id'
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
| document_id |
| -1          |
| 0           |
| 9999999999  |

@document @pin
Scenario Outline: Pin document when document_id is invalid
    # pin document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from value '<document_id>'
  And set request body param 'is_pinned' from value '1'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '422'
  And error loc is 'path' and 'document_id'
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
| document_id | error_type  |
| tabs        | int_parsing |
| spaces      | int_parsing |
| string(1)   | int_parsing |
| 123.5       | int_parsing |
| 123,0       | int_parsing |

@document @pin
Scenario Outline: Pin document when is_pinned is invalid
    # pin document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'is_pinned' from value '<is_pinned>'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '422'
  And error loc is 'body' and 'is_pinned'
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
| is_pinned | error_type   |
| none      | missing      |
| tabs      | bool_parsing |
| spaces    | bool_parsing |
| +1        | bool_parsing |
| -1        | bool_parsing |
| 2         | bool_parsing |
| string(0) | bool_parsing |
| string(8) | bool_parsing |

@document @pin
Scenario Outline: Pin document when is_pinned is correct
    # pin document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'is_pinned' from value '<is_pinned>'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '200'
  And response params contain 'document_id'
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
| is_pinned |
| TRUE      |
| True      |
| true      |
| YES       |
| yes       |
| Y         |
| y         |
| FALSE     |
| False     |
| false     |
| NO        |
| no        |
| N         |
| n         |
| 1         |
| 0         |

@document @pin
Scenario: Pin document when collection is locked
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
    # pin document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'is_pinned' from value '1'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '200'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And response contains '2' params
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
    # update document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'is_pinned' from value '1'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '200'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And response contains '2' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'

@document @pin
Scenario: Pin document when lock mode is enabled
    # enable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # update document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'is_pinned' from value '1'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '423'
    # disable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # pin document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'is_pinned' from value '1'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '200'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And response contains '2' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@document @pin
Scenario: Pin document when user is admin
    # pin document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'is_pinned' from value '1'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '200'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And response contains '2' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@document @pin
Scenario: Pin document when user is editor
    # pin document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'is_pinned' from value '1'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '200'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And response contains '2' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@document @pin
Scenario: Pin document when user is writer
    # pin document
Given set request header token from global param 'writer_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'is_pinned' from value '1'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@document @pin
Scenario: Pin document when user is reader
    # pin document
Given set request header token from global param 'reader_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'is_pinned' from value '1'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

@document @pin
Scenario: Pin document when token is missing
    # pin document
Given delete request header token 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'is_pinned' from value '1'
 When send 'PUT' request to url 'document/:document_id/pinned'
 Then response code is '403'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params