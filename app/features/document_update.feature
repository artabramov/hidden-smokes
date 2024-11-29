Feature: Update document

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

@document @update
Scenario Outline: Update document when collection_id not found
    # update document
Given set request header token from global param 'editor_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from value '<collection_id>'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
 Then response code is '422'
  And error loc is 'body' and 'collection_id'
  And error type is 'value_invalid'
  And response contains '1' params
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params

Examples:
| collection_id |
| -1            |
| 0             |
| 9999999999    |

@document @update
Scenario Outline: Update document when collection_id is invalid
    # update document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from value '<collection_id>'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
 Then response code is '422'
  And error loc is 'body' and 'collection_id'
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
| collection_id | error_type  |
| tabs          | int_parsing |
| spaces        | int_parsing |
| string(1)     | int_parsing |
| 123.5         | int_parsing |
| 123,0         | int_parsing |

@document @update
Scenario Outline: Update document when document_id not found
    # update document
Given set request header token from global param 'editor_token'
  And set request path param 'document_id' from value '<document_id>'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
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

@document @update
Scenario Outline: Update document when document_id is invalid
    # update document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from value '<document_id>'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
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

@document @update
Scenario Outline: Update document when is_flagged is invalid
    # update document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '<is_flagged>'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
 Then response code is '422'
  And error loc is 'body' and 'is_flagged'
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
| is_flagged | error_type   |
| none       | missing      |
| tabs       | bool_parsing |
| spaces     | bool_parsing |
| +1         | bool_parsing |
| -1         | bool_parsing |
| 2          | bool_parsing |
| string(0)  | bool_parsing |
| string(8)  | bool_parsing |

@document @update
Scenario Outline: Update document when is_flagged is correct
    # update document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '<is_flagged>'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
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
| is_flagged |
| TRUE       |
| True       |
| true       |
| YES        |
| yes        |
| Y          |
| y          |
| FALSE      |
| False      |
| false      |
| NO         |
| no         |
| N          |
| n          |
| 1          |
| 0          |

@document @update
Scenario Outline: Update document when document_filename is invalid
    # update document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from value '<document_filename>'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
 Then response code is '422'
  And error loc is 'body' and 'document_filename'
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
| document_filename | error_type       |
| none              | missing          |
| tabs              | string_too_short |
| spaces            | string_too_short |
| string(0)         | string_type      |
| string(257)       | string_too_long  |

@document @update
Scenario Outline: Update document when document_filename is correct
    # update document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from value '<document_filename>'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
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
| revision_filename |
| string(1)         |
| string(256)       |

@document @update
Scenario Outline: Update document when document_summary is invalid
    # update document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from value '<document_summary>'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
 Then response code is '422'
  And error loc is 'body' and 'document_summary'
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
| document_summary | error_type      |
| string(513)       | string_too_long |

@document @update
Scenario Outline: Update document when document_summary is correct
    # update document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from value '<document_summary>'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
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
| document_summary |
| none              |
| tabs              |
| spaces            |
| string(0)         |
| string(1)         |
| string(512)       |

@document @update
Scenario: Update document when collection is locked
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
    # update document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
 Then response code is '423'
  And error loc is 'path' and 'document_id'
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
    # update document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
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

@document @update
Scenario: Update document when lock mode is enabled
    # enable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # update document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
 Then response code is '423'
    # disable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # update document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
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

@document @update
Scenario: Update document when user is admin
    # update document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
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

@document @update
Scenario: Update document when user is editor
    # update document
Given set request header token from global param 'editor_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
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

@document @update
Scenario: Update document when user is writer
    # update document
Given set request header token from global param 'writer_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
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

@document @update
Scenario: Update document when user is reader
    # update document
Given set request header token from global param 'reader_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
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

@document @update
Scenario: Update document when token is missing
    # update document
Given delete request header token 
  And set request path param 'document_id' from global param 'document_id'
  And set request body param 'collection_id' from global param 'collection_id'
  And set request body param 'is_flagged' from value '0'
  And set request body param 'document_filename' from fake 'document_filename'
  And set request body param 'document_summary' from fake 'document_summary'
  And set request body param 'document_tags' from fake 'document_tags'
 When send 'PUT' request to url 'document/:document_id'
 Then response code is '403'
    # delete collection
Given set request header token from global param 'admin_token' 
  And set request path param 'collection_id' from global param 'collection_id'
 When send 'DELETE' request to url 'collection/:collection_id'
 Then response code is '200'
  And response params contain 'collection_id'
  And response contains '1' params
