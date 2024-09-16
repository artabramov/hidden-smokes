Feature: List revisions

Background: Authorize users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@revision @list
Scenario Outline: List revisions when document_id is invalid
Given set request token from global param 'admin_token' 
  And set request param 'document_id__eq' from value '<document_id>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
 Then response code is '422'
  And error loc is 'document_id__eq'
  And error type is '<error_type>'

Examples:
| collection_id | error_type         |
| tabs          | int_parsing        |
| spaces        | int_parsing        |
| 123.4         | int_parsing        |
| 123,0         | int_parsing        |
| string(0)     | int_parsing        |
| string(8)     | int_parsing        |

@revision @list
Scenario Outline: List revisions when document_id is correct
Given set request token from global param 'admin_token' 
  And set request param 'document_id__eq' from value '<document_id>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
 Then response code is '200'
  And response params contain 'revisions'
  And response params contain 'revisions_count'

Examples:
| document_id |
| none        |
| 0           |
| 0.0         |
| -123        |
| -123.0      |
| +123        |
| +123.0      |

@revision @list
Scenario Outline: List revisions when offset is invalid
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '<offset>'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
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

@revision @list
Scenario Outline: List revisions when offset is correct
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '<offset>'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
 Then response code is '200'
  And response params contain 'revisions'
  And response params contain 'revisions_count'

Examples:
| offset |
| 0      |
| 0.0    |
| 123    |
| 123.0  |
| +123   |

@revision @list
Scenario Outline: List revisions when limit is invalid
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '<limit>'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
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

@revision @list
Scenario Outline: List revisions when limit is correct
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '<limit>'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
 Then response code is '200'
  And response params contain 'revisions'
  And response params contain 'revisions_count'

Examples:
| limit |
| 1     |
| 123   |
| 123.0 |
| +123  |

@revision @list
Scenario Outline: List revisions when order_by is invalid
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value '<order_by>'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
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

@revision @list
Scenario Outline: List revisions when order_by is correct
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value '<order_by>'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
 Then response code is '200'
  And response params contain 'revisions'
  And response params contain 'revisions_count'

Examples:
| order_by          |
| id                |
| created_date      |

@revision @list
Scenario Outline: List revisions when order is invalid
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value '<order>'
 When send 'GET' request to url 'revisions'
 Then response code is '422'
  And error loc is 'order'
  And error type is '<error_type>'

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

@revision @list
Scenario Outline: List revisions when order is correct
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value '<order>'
 When send 'GET' request to url 'revisions'
 Then response code is '200'
  And response params contain 'revisions'
  And response params contain 'revisions_count'

Examples:
| order |
| asc   |
| desc  |

@revision @list
Scenario: List revisions when app is locked
    # lock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'service/lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
    # list revisions
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
 Then response code is '503'
    # unlock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'service/unlock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
    # list revisions
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
 Then response code is '200'
  And response params contain 'revisions'
  And response params contain 'revisions_count'

@revision @list
Scenario: List revisions when user is admin
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
 Then response code is '200'
  And response params contain 'revisions'
  And response params contain 'revisions_count'

@revision @list
Scenario: List revisions when user is editor
Given set request token from global param 'editor_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
 Then response code is '200'
  And response params contain 'revisions'
  And response params contain 'revisions_count'

@revision @list
Scenario: List revisions when user is writer
Given set request token from global param 'writer_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
 Then response code is '200'
  And response params contain 'revisions'
  And response params contain 'revisions_count'

@revision @list
Scenario: List revisions when user is reader
Given set request token from global param 'reader_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
 Then response code is '200'
  And response params contain 'revisions'
  And response params contain 'revisions_count'

@revision @list
Scenario: List revisions when token is missing
Given delete request token
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'revisions'
 Then response code is '403'
