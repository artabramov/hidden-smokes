Feature: List documents

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
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
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
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

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
Scenario Outline: List documents when document_name__ilike is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'document_name__ilike' from value '<document_name>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| document_name | error_type       |
| none           | missing          |
| tabs           | string_too_short |
| spaces         | string_too_short |
| string(0)      | string_type      |
| string(255)    | string_too_long  |

@document @list
Scenario Outline: List documents when comments_count__ge is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'comments_count__ge' from value '<comments_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'comments_count__ge'
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
| comments_count | error_type  |
| tabs           | int_parsing |
| spaces         | int_parsing |
| 123.4          | int_parsing |
| 123,0          | int_parsing |
| string(0)      | int_parsing |
| string(8)      | int_parsing |

@document @list
Scenario Outline: List documents when comments_count__ge is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'comments_count__ge' from value '<comments_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| comments_count |
| none           |
| 0              |
| 0.0            |
| -123           |
| -123.0         |
| +123           |
| +123.0         |

@document @list
Scenario Outline: List documents when comments_count__le is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'comments_count__le' from value '<comments_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'comments_count__le'
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
| comments_count | error_type  |
| tabs           | int_parsing |
| spaces         | int_parsing |
| 123.4          | int_parsing |
| 123,0          | int_parsing |
| string(0)      | int_parsing |
| string(8)      | int_parsing |

@document @list
Scenario Outline: List documents when comments_count__le is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'comments_count__le' from value '<comments_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| comments_count |
| none           |
| 0              |
| 0.0            |
| -123           |
| -123.0         |
| +123           |
| +123.0         |

@document @list
Scenario Outline: List documents when revisions_count__ge is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_count__ge' from value '<revisions_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'revisions_count__ge'
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
| revisions_count | error_type  |
| tabs          | int_parsing |
| spaces        | int_parsing |
| 123.4         | int_parsing |
| 123,0         | int_parsing |
| string(0)     | int_parsing |
| string(8)     | int_parsing |

@document @list
Scenario Outline: List documents when revisions_count__ge is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_count__ge' from value '<revisions_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| revisions_count |
| none          |
| 0             |
| 0.0           |
| -123          |
| -123.0        |
| +123          |
| +123.0        |

@document @list
Scenario Outline: List documents when revisions_count__le is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_count__le' from value '<revisions_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'revisions_count__le'
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
| revisions_count | error_type  |
| tabs          | int_parsing |
| spaces        | int_parsing |
| 123.4         | int_parsing |
| 123,0         | int_parsing |
| string(0)     | int_parsing |
| string(8)     | int_parsing |

@document @list
Scenario Outline: List documents when revisions_count__le is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_count__le' from value '<revisions_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| revisions_count |
| none          |
| 0             |
| 0.0           |
| -123          |
| -123.0        |
| +123          |
| +123.0        |

@document @list
Scenario Outline: List documents when revisions_size__ge is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_size__ge' from value '<revisions_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'revisions_size__ge'
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
| revisions_size | error_type  |
| tabs         | int_parsing |
| spaces       | int_parsing |
| 123.4        | int_parsing |
| 123,0        | int_parsing |
| string(0)    | int_parsing |
| string(8)    | int_parsing |

@document @list
Scenario Outline: List documents when revisions_size__ge is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_size__ge' from value '<revisions_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| revisions_size |
| none         |
| 0            |
| 0.0          |
| -123         |
| -123.0       |
| +123         |
| +123.0       |

@document @list
Scenario Outline: List documents when revisions_size__le is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_size__le' from value '<revisions_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'revisions_size__le'
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
| revisions_size | error_type  |
| tabs           | int_parsing |
| spaces         | int_parsing |
| 123.4          | int_parsing |
| 123,0          | int_parsing |
| string(0)      | int_parsing |
| string(8)      | int_parsing |

@document @list
Scenario Outline: List documents when revisions_size__le is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_size__le' from value '<revisions_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| revisions_size |
| none         |
| 0            |
| 0.0          |
| -123         |
| -123.0       |
| +123         |
| +123.0       |

@document @list
Scenario Outline: List documents when downloads_count__ge is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'downloads_count__ge' from value '<downloads_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'downloads_count__ge'
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
| downloads_count | error_type  |
| tabs            | int_parsing |
| spaces          | int_parsing |
| 123.4           | int_parsing |
| 123,0           | int_parsing |
| string(0)       | int_parsing |
| string(8)       | int_parsing |

@document @list
Scenario Outline: List documents when downloads_count__ge is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'downloads_count__ge' from value '<downloads_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| downloads_count |
| none            |
| 0               |
| 0.0             |
| -123            |
| -123.0          |
| +123            |
| +123.0          |

@document @list
Scenario Outline: List documents when downloads_count__le is invalid
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'downloads_count__le' from value '<downloads_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'query' and 'downloads_count__le'
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
| downloads_count | error_type  |
| tabs            | int_parsing |
| spaces          | int_parsing |
| 123.4           | int_parsing |
| 123,0           | int_parsing |
| string(0)       | int_parsing |
| string(8)       | int_parsing |

@document @list
Scenario Outline: List documents when downloads_count__le is correct
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'downloads_count__le' from value '<downloads_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'
  And response contains '2' params
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| downloads_count |
| none            |
| 0               |
| 0.0             |
| -123            |
| -123.0          |
| +123            |
| +123.0          |

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
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

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
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

Examples:
| order_by        |
| id              |
| created_date    |
| updated_date    |
| user_id         |
| collection_id   |
| document_name  |
| comments_count  |
| revisions_count |
| revisions_size  |
| downloads_count |

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
| rand  |

@document @list
Scenario: List documents when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # list documents
Given set request header token from global param 'admin_token' 
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
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
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

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
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

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
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

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
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

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
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params

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
    # delete document
Given set request header token from global param 'admin_token' 
  And set request path param 'document_id' from global param 'document_id'
 When send 'DELETE' request to url 'document/:document_id'
 Then response code is '200'
  And response params contain 'document_id'
  And response contains '1' params
