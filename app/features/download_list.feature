Feature: List downloads

Background: Authorize users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@download @list
Scenario Outline: List downloads when document_id is invalid
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'document_id__eq' from value '<document_id>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
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

@download @list
Scenario Outline: List downloads when document_id is correct
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'document_id__eq' from value '<document_id>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
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

@download @list
Scenario Outline: List downloads when offset is invalid
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '<offset>'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
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

@download @list
Scenario Outline: List downloads when offset is correct
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '<offset>'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params

Examples:
| offset |
| 0      |
| 0.0    |
| 123    |
| 123.0  |
| +123   |

@download @list
Scenario Outline: List downloads when limit is invalid
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '<limit>'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
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

@download @list
Scenario Outline: List downloads when limit is correct
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '<limit>'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params

Examples:
| limit |
| 1     |
| 123   |
| 123.0 |
| +123  |

@download @list
Scenario Outline: List downloads when order_by is invalid
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value '<order_by>'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
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

@download @list
Scenario Outline: List downloads when order_by is correct
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value '<order_by>'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params

Examples:
| order_by          |
| id                |
| created_date      |

@download @list
Scenario Outline: List downloads when order is invalid
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value '<order>'
 When send 'GET' request to url 'downloads'
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

@download @list
Scenario Outline: List downloads when order is correct
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value '<order>'
 When send 'GET' request to url 'downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params

Examples:
| order |
| asc   |
| desc  |

@download @list
Scenario: List downloads when app is locked
    # lock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
 Then response code is '503'
    # unlock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/unlock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params

@download @list
Scenario: List downloads when user is admin
    # list downloads
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params

@download @list
Scenario: List downloads when user is editor
    # list downloads
Given set request token from global param 'editor_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@download @list
Scenario: List downloads when user is writer
    # list downloads
Given set request token from global param 'writer_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@download @list
Scenario: List downloads when user is reader
    # list downloads
Given set request token from global param 'reader_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
 Then response code is '403'
  And error loc is 'user_token'
  And error type is 'user_rejected'

@download @list
Scenario: List downloads when token is missing
    # list downloads
Given delete request token
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'downloads'
 Then response code is '403'
