Feature: List collections

Background: Authorize users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@collection @list
Scenario Outline: List collections when collection_name is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'collection_name__ilike' from value '<collection_name>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

Examples:
| collection_name |
| none            |
| tabs            |
| spaces          |
| 123             |
| string(0)       |
| string(8)       |

@collection @list
Scenario Outline: List collections when is_locked is invalid
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'is_locked__eq' from value '<is_locked>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'query' and 'is_locked__eq'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| is_locked | error_type   |
| tabs      | bool_parsing |
| spaces    | bool_parsing |
| +1        | bool_parsing |
| -1        | bool_parsing |
| 2         | bool_parsing |
| 123       | bool_parsing |
| string(0) | bool_parsing |
| string(8) | bool_parsing |

@collection @list
Scenario Outline: List collections when is_locked is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'is_locked__eq' from value '<is_locked>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

Examples:
| is_locked |
| TRUE      |
| True      |
| true      |
| FALSE     |
| False     |
| false     |
| 1         |
| 0         |

@collection @list
Scenario Outline: List collections when user_id__eq is invalid
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'user_id__eq' from value '<user_id>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'query' and 'user_id__eq'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| user_id         | error_type  |
| tabs            | int_parsing |
| spaces          | int_parsing |
| 123.4           | int_parsing |
| 123,0           | int_parsing |
| string(0)       | int_parsing |
| string(8)       | int_parsing |

@collection @list
Scenario Outline: List collections when user_id__eq is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'user_id__eq' from value '<user_id>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

Examples:
| user_id |
| none    |
| 0       |
| 0.0     |
| -123    |
| -123.0  |
| +123    |
| +123.0  |

@collection @list
Scenario Outline: List collections when documents_count__ge is invalid
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'documents_count__ge' from value '<documents_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'query' and 'documents_count__ge'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| documents_count | error_type  |
| tabs            | int_parsing |
| spaces          | int_parsing |
| 123.4           | int_parsing |
| 123,0           | int_parsing |
| string(0)       | int_parsing |
| string(8)       | int_parsing |

@collection @list
Scenario Outline: List collections when documents_count__ge is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'documents_count__ge' from value '<documents_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

Examples:
| documents_count |
| none            |
| 0               |
| 0.0             |
| -123            |
| -123.0          |
| +123            |
| +123.0          |

@collection @list
Scenario Outline: List collections when documents_count__le is invalid
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'documents_count__le' from value '<documents_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'query' and 'documents_count__le'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| documents_count | error_type  |
| tabs            | int_parsing |
| spaces          | int_parsing |
| 123.4           | int_parsing |
| 123,0           | int_parsing |
| string(0)       | int_parsing |
| string(8)       | int_parsing |

@collection @list
Scenario Outline: List collections when documents_count__le is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'documents_count__le' from value '<documents_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

Examples:
| documents_count |
| none            |
| 0               |
| 0.0             |
| -123            |
| -123.0          |
| +123            |
| +123.0          |

@collection @list
Scenario Outline: List collections when offset is invalid
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'offset' from value '<offset>'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
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

@collection @list
Scenario Outline: List collections when offset is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'offset' from value '<offset>'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

Examples:
| offset |
| 0      |
| 0.0    |
| 123    |
| 123.0  |
| +123   |

@collection @list
Scenario Outline: List collections when limit is invalid
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '<limit>'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
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

@collection @list
Scenario Outline: List collections when limit is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '<limit>'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

Examples:
| limit |
| 1     |
| 123   |
| 123.0 |
| +123  |

@collection @list
Scenario Outline: List collections when order_by is invalid
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value '<order_by>'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
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

@collection @list
Scenario Outline: List collections when order_by is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value '<order_by>'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

Examples:
| order_by        |
| id              |
| created_date    |
| updated_date    |
| locked_date     |
| user_id         |
| is_locked       |
| collection_name |
| documents_count |

@collection @list
Scenario Outline: List collections when order is invalid
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value '<order>'
 When send 'GET' request to url 'collections'
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

@collection @list
Scenario Outline: List collections when order is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value '<order>'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

Examples:
| order |
| asc   |
| desc  |
| rand  |

@collection @list
Scenario: List collections when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # list collections
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # list collections
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

@collection @list
Scenario: List collections when user is admin
    # list collections
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

@collection @list
Scenario: List collections when user is editor
    # list collections
Given set request header token from global param 'editor_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

@collection @list
Scenario: List collections when user is writer
    # list collections
Given set request header token from global param 'writer_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

@collection @list
Scenario: List collections when user is reader
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'
  And response contains '2' params

@collection @list
Scenario: List collections when token is missing
    # list collections
Given delete request header token 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '403'
