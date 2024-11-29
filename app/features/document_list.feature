Feature: List documents

Background: Auth users and upload document
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@document @list
Scenario Outline: List documents when collection_id is invalid
    # list documents
Given set request header token from global param 'admin_token'
  And set request query param 'collection_id__eq' from value '<collection_id>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'collection_id__eq'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| collection_id | error_type  |
| tabs          | int_parsing |
| spaces        | int_parsing |
| 123.4         | int_parsing |
| 123,0         | int_parsing |
| string(0)     | int_parsing |
| string(8)     | int_parsing |

@document @list
Scenario Outline: List documents when collection_id is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'collection_id__eq' from value '<collection_id>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

Examples:
| collection_id |
| none          |
| 0             |
| 0.0           |
| -123          |
| -123.0        |
| +123          |
| +123.0        |

@document @list
Scenario Outline: List documents when partner_id is invalid
    # list documents
Given set request header token from global param 'admin_token'
  And set request query param 'partner_id__eq' from value '<partner_id>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'partner_id__eq'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| partner_id | error_type  |
| tabs       | int_parsing |
| spaces     | int_parsing |
| 123.4      | int_parsing |
| 123,0      | int_parsing |
| string(0)  | int_parsing |
| string(8)  | int_parsing |

@document @list
Scenario Outline: List documents when partner_id is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'partner_id__eq' from value '<partner_id>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

Examples:
| partner_id |
| none       |
| 0          |
| 0.0        |
| -123       |
| -123.0     |
| +123       |
| +123.0     |

@document @list
Scenario Outline: List documents when is_pinned is invalid
    # list documents
Given set request header token from global param 'admin_token'
  And set request query param 'is_pinned__eq' from value '<is_pinned>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'is_pinned__eq'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| is_pinned | error_type   |
| tabs      | bool_parsing |
| spaces    | bool_parsing |
| +1        | bool_parsing |
| -1        | bool_parsing |
| 2         | bool_parsing |
| 123       | bool_parsing |
| string(0) | bool_parsing |
| string(8) | bool_parsing |

@document @list
Scenario Outline: List documents when is_pinned is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'is_pinned__eq' from value '<is_pinned>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

Examples:
| is_pinned |
| TRUE      |
| True      |
| true      |
| FALSE     |
| False     |
| false     |
| 1         |
| 0         |

@document @list
Scenario Outline: List documents when document_filename__ilike is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'document_filename__ilike' from value '<document_filename>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

Examples:
| document_filename | error_type       |
| none          | missing          |
| tabs          | string_too_short |
| spaces        | string_too_short |
| string(0)     | string_type      |
| string(255)   | string_too_long  |

@document @list
Scenario Outline: List documents when document_size__ge is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'document_size__ge' from value '<document_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'document_size__ge'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| document_size | error_type  |
| tabs          | int_parsing |
| spaces        | int_parsing |
| 123.4         | int_parsing |
| 123,0         | int_parsing |
| string(0)     | int_parsing |
| string(8)     | int_parsing |

@document @list
Scenario Outline: List documents when document_size__ge is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'document_size__ge' from value '<document_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

Examples:
| document_size |
| none          |
| 0             |
| 0.0           |
| -123          |
| -123.0        |
| +123          |
| +123.0        |

@document @list
Scenario Outline: List documents when document_size__le is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'document_size__le' from value '<document_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'document_size__le'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| document_size | error_type  |
| tabs          | int_parsing |
| spaces        | int_parsing |
| 123.4         | int_parsing |
| 123,0         | int_parsing |
| string(0)     | int_parsing |
| string(8)     | int_parsing |

@document @list
Scenario Outline: List documents when document_size__le is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'document_size__le' from value '<document_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

Examples:
| document_size |
| none          |
| 0             |
| 0.0           |
| -123          |
| -123.0        |
| +123          |
| +123.0        |

@document @list
Scenario Outline: List documents when document_mimetype__ilike is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'document_mimetype__ilike' from value '<document_mimetype>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

Examples:
| document_mimetype | error_type       |
| none              | missing          |
| tabs              | string_too_short |
| spaces            | string_too_short |
| string(0)         | string_type      |
| string(255)       | string_too_long  |

@document @list
Scenario Outline: List documents when tag_value is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'tag_value__eq' from value '<tag_value>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

Examples:
| tag_value |
| none      |
| tabs      |
| spaces    |
| 0         |
| 123       |
| string(0) |
| string(8) |

@document @list
Scenario Outline: List documents when offset is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '<offset>'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'offset'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| offset    | error_type         |
| none      | missing            |
| tabs      | int_parsing        |
| spaces    | int_parsing        |
| 123.4     | int_parsing        |
| 123,0     | int_parsing        |
| -123      | greater_than_equal |
| string(0) | int_parsing        |
| string(8) | int_parsing        |

@document @list
Scenario Outline: List documents when offset is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '<offset>'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

Examples:
| offset |
| 0      |
| 0.0    |
| 123    |
| 123.0  |
| +123   |

@document @list
Scenario Outline: List documents when limit is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '<limit>'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'limit'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| limit     | error_type         |
| none      | missing            |
| tabs      | int_parsing        |
| spaces    | int_parsing        |
| 0         | greater_than_equal |
| 0.0       | greater_than_equal |
| 123.4     | int_parsing        |
| 123,0     | int_parsing        |
| -123      | greater_than_equal |
| string(0) | int_parsing        |
| string(8) | int_parsing        |

@document @list
Scenario Outline: List documents when limit is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '<limit>'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

Examples:
| limit |
| 1     |
| 123   |
| 123.0 |
| +123  |

@document @list
Scenario Outline: List documents when order_by is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value '<order_by>'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'order_by'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| order_by  | error_type    |
| none      | missing       |
| tabs      | literal_error |
| spaces    | literal_error |
| 0         | literal_error |
| 123       | literal_error |
| string(8) | literal_error |

@document @list
Scenario Outline: List documents when order_by is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value '<order_by>'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

Examples:
| order_by          |
| id                |
| created_date      |
| updated_date      |
| user_id           |
| collection_id     |
| partner_id        |
| document_filename |
| document_size     |
| document_mimetype |
| comments_count    |
| revisions_count   |
| downloads_count   |

@document @list
Scenario Outline: List documents when order is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value '<order>'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'order'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| order  | error_type    |
| none   | missing       |
| tabs   | literal_error |
| spaces | literal_error |
| 0      | literal_error |
| 123    | literal_error |
| ASC    | literal_error |
| DESC   | literal_error |

@document @list
Scenario Outline: List documents when order is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value '<order>'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

Examples:
| order |
| asc   |
| desc  |
| rand  |

@document @list
Scenario: List documents when lock mode is enabled
    # enable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '1'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '423'
    # disable lock mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_locked' from value '0'
 When send 'PUT' request to url 'locked'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

@document @list
Scenario: List documents when user is admin
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

@document @list
Scenario: List documents when user is editor
    # list documents
Given set request header token from global param 'editor_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

@document @list
Scenario: List documents when user is writer
    # list documents
Given set request header token from global param 'writer_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

@document @list
Scenario: List documents when user is reader
    # list documents
Given set request header token from global param 'reader_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params

@document @list
Scenario: List documents when token is missing
    # list documents
Given delete request header token
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '403'
