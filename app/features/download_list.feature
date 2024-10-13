Feature: List downloads

Background: Auth users and upload document
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # upload document
Given set request header token from global param 'admin_token' 
  And set request file from sample format 'pdf'
 When send 'POST' request to url 'document'
 Then response code is '201'
  And response params contain 'document_id'
  And response params contain 'revision_id'
  And response contains '2' params
  And save response param 'document_id' to global param 'document_id'
    # remove file from request
Given delete request file

@download @list
Scenario Outline: List downloads when document_id is invalid
    # list downloads
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from value '<document_id>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '404'
  And error loc is 'path' and 'document_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| document_id |
| -1           |
| 0            |
| 9999999999   |

@download @list
Scenario Outline: List downloads when document_id is correct
    # list downloads
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

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
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '<offset>'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '422'
  And error loc is 'query' and 'offset'
  And error type is '<error_type>'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
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

@download @list
Scenario Outline: List downloads when offset is correct
    # list downloads
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '<offset>'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

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
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '<limit>'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '422'
  And error loc is 'query' and 'limit'
  And error type is '<error_type>'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
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

@download @list
Scenario Outline: List downloads when limit is correct
    # list downloads
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '<limit>'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| limit |
| 1     |
| 123   |
| 123.0 |
| +123  |

@download @list
Scenario Outline: List downloads when order_by is invalid
    # list downloads
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value '<order_by>'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '422'
  And error loc is 'query' and 'order_by'
  And error type is '<error_type>'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

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
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value '<order_by>'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| order_by          |
| id                |
| created_date      |

@download @list
Scenario Outline: List downloads when order is invalid
    # list downloads
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value '<order>'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '422'
  And error loc is 'query' and 'order'
  And error type is '<error_type>'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
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

@download @list
Scenario Outline: List downloads when order is correct
    # list downloads
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value '<order>'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| order |
| asc   |
| desc  |

@download @list
Scenario: List downloads when app is locked
    # create lock
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
  And response contains '1' params
    # list downloads
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '423'
    # delete lock
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
  And response contains '1' params
    # list downloads
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@download @list
Scenario: List downloads when user is admin
    # list downloads
Given set request header token from global param 'admin_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '200'
  And response params contain 'downloads'
  And response params contain 'downloads_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@download @list
Scenario: List downloads when user is editor
    # list downloads
Given set request header token from global param 'editor_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@download @list
Scenario: List downloads when user is writer
    # list downloads
Given set request header token from global param 'writer_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@download @list
Scenario: List downloads when user is reader
    # list downloads
Given set request header token from global param 'reader_token'
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

@download @list
Scenario: List downloads when token is missing
    # list downloads
Given delete request header token
  And set request path param 'document_id' from global param 'document_id'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'document/:document_id/downloads'
 Then response code is '403'
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params
