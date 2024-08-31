Feature: Collections list

Background: User auth
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@collection @list
Scenario Outline: When collection_name__ilike is correct
Given set request token from global param 'reader_token' 
  And set request param 'collection_name__ilike' from value '<collection_name>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

Examples:
| collection_name |
| none            |
| tabs            |
| spaces          |
| 123             |
| string(0)       |
| string(8)       |

@collection @list
Scenario Outline: When is_locked__eq is invalid
Given set request token from global param 'reader_token' 
  And set request param 'is_locked__eq' from value '<is_locked>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'is_locked__eq'
  And error type is '<error_type>'

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
Scenario Outline: When is_locked__eq is correct
Given set request token from global param 'reader_token' 
  And set request param 'is_locked__eq' from value '<is_locked>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

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
Scenario Outline: When documents_count__ge is invalid
Given set request token from global param 'reader_token' 
  And set request param 'documents_count__ge' from value '<documents_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'documents_count__ge'
  And error type is '<error_type>'

Examples:
| documents_count | error_type         |
| tabs            | int_parsing        |
| spaces          | int_parsing        |
| 123.4           | int_parsing        |
| 123,0           | int_parsing        |
| string(0)       | int_parsing        |
| string(8)       | int_parsing        |

@collection @list
Scenario Outline: When documents_count__ge is correct
Given set request token from global param 'reader_token' 
  And set request param 'documents_count__ge' from value '<documents_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

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
Scenario Outline: When documents_count__le is invalid
Given set request token from global param 'reader_token' 
  And set request param 'documents_count__le' from value '<documents_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'documents_count__le'
  And error type is '<error_type>'

Examples:
| documents_count | error_type         |
| tabs            | int_parsing        |
| spaces          | int_parsing        |
| 123.4           | int_parsing        |
| 123,0           | int_parsing        |
| string(0)       | int_parsing        |
| string(8)       | int_parsing        |

@collection @list
Scenario Outline: When documents_count__le is correct
Given set request token from global param 'reader_token' 
  And set request param 'documents_count__le' from value '<documents_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

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
Scenario Outline: When documents_size__ge is invalid
Given set request token from global param 'reader_token' 
  And set request param 'documents_size__ge' from value '<documents_size>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'documents_size__ge'
  And error type is '<error_type>'

Examples:
| documents_size | error_type         |
| tabs           | int_parsing        |
| spaces         | int_parsing        |
| 123.4          | int_parsing        |
| 123,0          | int_parsing        |
| string(0)      | int_parsing        |
| string(8)      | int_parsing        |

@collection @list
Scenario Outline: When documents_size__ge is correct
Given set request token from global param 'reader_token' 
  And set request param 'documents_size__ge' from value '<documents_size>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

Examples:
| documents_size |
| none           |
| 0              |
| 0.0            |
| -123           |
| -123.0         |
| +123           |
| +123.0         |

@collection @list
Scenario Outline: When documents_size__le is invalid
Given set request token from global param 'reader_token' 
  And set request param 'documents_size__le' from value '<documents_size>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'documents_size__le'
  And error type is '<error_type>'

Examples:
| documents_size | error_type         |
| tabs           | int_parsing        |
| spaces         | int_parsing        |
| 123.4          | int_parsing        |
| 123,0          | int_parsing        |
| string(0)      | int_parsing        |
| string(8)      | int_parsing        |

@collection @list
Scenario Outline: When documents_size__le is correct
Given set request token from global param 'reader_token' 
  And set request param 'documents_size__le' from value '<documents_size>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

Examples:
| documents_size |
| none           |
| 0              |
| 0.0            |
| -123           |
| -123.0         |
| +123           |
| +123.0         |

@collection @list
Scenario Outline: When offset is invalid
Given set request token from global param 'reader_token' 
  And set request param 'offset' from value '<offset>'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'offset'
  And error type is '<error_type>'

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
Scenario Outline: When offset is correct
Given set request token from global param 'reader_token' 
  And set request param 'offset' from value '<offset>'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

Examples:
| offset |
| 0      |
| 0.0    |
| 123    |
| 123.0  |
| +123   |

@collection @list
Scenario Outline: When limit is invalid
Given set request token from global param 'reader_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '<limit>'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'limit'
  And error type is '<error_type>'

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
Scenario Outline: When limit is correct
Given set request token from global param 'reader_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '<limit>'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

Examples:
| limit |
| 1     |
| 123   |
| 123.0 |
| +123  |

@collection @list
Scenario Outline: When order_by is invalid
Given set request token from global param 'reader_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value '<order_by>'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'order_by'
  And error type is '<error_type>'

Examples:
| order_by  | error_type    |
| none      | missing       |
| tabs      | literal_error |
| spaces    | literal_error |
| 0         | literal_error |
| 123       | literal_error |
| string(8) | literal_error |

@collection @list
Scenario Outline: When order_by is correct
Given set request token from global param 'reader_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value '<order_by>'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

Examples:
| order_by        |
| id              |
| created_date    |
| updated_date    |
| user_id         |
| collection_name |
| documents_count |
| revisions_count |
| revisions_size  |
| originals_size  |

@collection @list
Scenario Outline: When order is invalid
Given set request token from global param 'reader_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value '<order>'
 When send 'GET' request to url 'collections'
 Then response code is '422'
  And error loc is 'order'
  And error type is '<error_type>'

Examples:
| order     | error_type    |
| none      | missing       |
| tabs      | literal_error |
| spaces    | literal_error |
| 0         | literal_error |
| 123       | literal_error |
| string(8) | literal_error |

@collection @list
Scenario Outline: When order is correct
Given set request token from global param 'reader_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value '<order>'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

Examples:
| order |
| asc   |
| desc  |

@collection @list
Scenario: When user_role is reader
Given set request token from global param 'reader_token' 
  And set request param 'offset' from value '1'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

@collection @list
Scenario: When user_role is writer
Given set request token from global param 'writer_token' 
  And set request param 'offset' from value '1'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

@collection @list
Scenario: When user_role is editor
Given set request token from global param 'editor_token' 
  And set request param 'offset' from value '1'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

@collection @list
Scenario: When user_role is admin
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '1'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '200'
  And response params contain 'collections'
  And response params contain 'collections_count'

@collection @list
Scenario: When user_token is missing
Given delete request token 
  And set request param 'offset' from value '1'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'collections'
 Then response code is '403'
