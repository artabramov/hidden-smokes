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
Scenario Outline: List collections when revisions_count__ge is invalid
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'revisions_count__ge' from value '<revisions_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'query' and 'revisions_count__ge'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| revisions_count | error_type  |
| tabs            | int_parsing |
| spaces          | int_parsing |
| 123.4           | int_parsing |
| 123,0           | int_parsing |
| string(0)       | int_parsing |
| string(8)       | int_parsing |

@collection @list
Scenario Outline: List collections when revisions_count__ge is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'revisions_count__ge' from value '<revisions_count>'
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
| revisions_count |
| none            |
| 0               |
| 0.0             |
| -123            |
| -123.0          |
| +123            |
| +123.0          |

@collection @list
Scenario Outline: List collections when revisions_count__le is invalid
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'revisions_count__le' from value '<revisions_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'query' and 'revisions_count__le'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| revisions_count | error_type  |
| tabs            | int_parsing |
| spaces          | int_parsing |
| 123.4           | int_parsing |
| 123,0           | int_parsing |
| string(0)       | int_parsing |
| string(8)       | int_parsing |

@collection @list
Scenario Outline: List collections when revisions_count__le is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'revisions_count__le' from value '<revisions_count>'
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
| revisions_count |
| none            |
| 0               |
| 0.0             |
| -123            |
| -123.0          |
| +123            |
| +123.0          |

@collection @list
Scenario Outline: List collections when revisions_size__ge is invalid
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'revisions_size__ge' from value '<revisions_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'query' and 'revisions_size__ge'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| revisions_size | error_type  |
| tabs           | int_parsing |
| spaces         | int_parsing |
| 123.4          | int_parsing |
| 123,0          | int_parsing |
| string(0)      | int_parsing |
| string(8)      | int_parsing |

@collection @list
Scenario Outline: List collections when revisions_size__ge is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'revisions_size__ge' from value '<revisions_size>'
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
| revisions_size |
| none           |
| 0              |
| 0.0            |
| -123           |
| -123.0         |
| +123           |
| +123.0         |

@collection @list
Scenario Outline: List collections when revisions_size__le is invalid
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'revisions_size__le' from value '<revisions_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'query' and 'revisions_size__le'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| revisions_size | error_type  |
| tabs           | int_parsing |
| spaces         | int_parsing |
| 123.4          | int_parsing |
| 123,0          | int_parsing |
| string(0)      | int_parsing |
| string(8)      | int_parsing |

@collection @list
Scenario Outline: List collections when revisions_size__le is correct
    # list collections
Given set request header token from global param 'reader_token' 
  And set request query param 'revisions_size__le' from value '<revisions_size>'
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
| revisions_size |
| none           |
| 0              |
| 0.0            |
| -123           |
| -123.0         |
| +123           |
| +123.0         |

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
| user_id         |
| collection_name |
| documents_count |
| revisions_count   |
| revisions_size    |

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

# @collection @list
# Scenario: List collections when app is locked
#     # lock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/lock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'True'
#     # list collections
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'collections'
#  Then response code is '503'
#     # unlock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/unlock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'False'
#     # list collections
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'collections'
#  Then response code is '200'
#   And response params contain 'collections'
#   And response params contain 'collections_count'
#   And response contains '2' params

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
