Feature: List comments

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@comment @list
Scenario Outline: List comments when document_id is invalid
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'document_id__eq' from value '<document_id>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
 Then response code is '422'
  And error loc is 'query' and 'document_id__eq'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| collection_id | error_type         |
| tabs          | int_parsing        |
| spaces        | int_parsing        |
| 123.4         | int_parsing        |
| 123,0         | int_parsing        |
| string(0)     | int_parsing        |
| string(8)     | int_parsing        |

@comment @list
Scenario Outline: List comments when document_id is correct
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'document_id__eq' from value '<document_id>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
 Then response code is '200'
  And response params contain 'comments'
  And response params contain 'comments_count'
  And response contains '2' params

Examples:
| document_id |
| none        |
| 0           |
| 0.0         |
| -123        |
| -123.0      |
| +123        |
| +123.0      |

@comment @list
Scenario Outline: List comments when offset is invalid
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '<offset>'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
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

@comment @list
Scenario Outline: List comments when offset is correct
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '<offset>'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
 Then response code is '200'
  And response params contain 'comments'
  And response params contain 'comments_count'
  And response contains '2' params

Examples:
| offset |
| 0      |
| 0.0    |
| 123    |
| 123.0  |
| +123   |

@comment @list
Scenario Outline: List comments when limit is invalid
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '<limit>'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
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

@comment @list
Scenario Outline: List comments when limit is correct
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '<limit>'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
 Then response code is '200'
  And response params contain 'comments'
  And response params contain 'comments_count'
  And response contains '2' params

Examples:
| limit |
| 1     |
| 123   |
| 123.0 |
| +123  |

@comment @list
Scenario Outline: List comments when order_by is invalid
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value '<order_by>'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
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

@comment @list
Scenario Outline: List comments when order_by is correct
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value '<order_by>'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
 Then response code is '200'
  And response params contain 'comments'
  And response params contain 'comments_count'
  And response contains '2' params

Examples:
| order_by          |
| id                |
| created_date      |

@comment @list
Scenario Outline: List comments when order is invalid
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value '<order>'
 When send 'GET' request to url 'comments'
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
| RAND   | literal_error |
| rand   | literal_error |

@comment @list
Scenario Outline: List comments when order is correct
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value '<order>'
 When send 'GET' request to url 'comments'
 Then response code is '200'
  And response params contain 'comments'
  And response params contain 'comments_count'
  And response contains '2' params

Examples:
| order |
| asc   |
| desc  |

@comment @list
Scenario: List comments when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '1'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '0'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
 Then response code is '200'
  And response params contain 'comments'
  And response params contain 'comments_count'

@comment @list
Scenario: List comments when user is admin
    # list comments
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
 Then response code is '200'
  And response params contain 'comments'
  And response params contain 'comments_count'
  And response contains '2' params

@comment @list
Scenario: List comments when user is editor
    # list comments
Given set request header token from global param 'editor_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
 Then response code is '200'
  And response params contain 'comments'
  And response params contain 'comments_count'
  And response contains '2' params

@comment @list
Scenario: List comments when user is writer
    # list comments
Given set request header token from global param 'writer_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
 Then response code is '200'
  And response params contain 'comments'
  And response params contain 'comments_count'
  And response contains '2' params

@comment @list
Scenario: List comments when user is reader
    # list comments
Given set request header token from global param 'reader_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
 Then response code is '200'
  And response params contain 'comments'
  And response params contain 'comments_count'
  And response contains '2' params

@comment @list
Scenario: List comments when token is missing
    # list comments
Given delete request header token
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'comments'
 Then response code is '403'
