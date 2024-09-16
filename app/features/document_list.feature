Feature: List documents

Background: Authorize users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@document @list
Scenario Outline: List documents when collection_id is invalid
Given set request token from global param 'admin_token' 
  And set request param 'collection_id__eq' from value '<collection_id>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'collection_id__eq'
  And error type is '<error_type>'

Examples:
| collection_id | error_type         |
| tabs          | int_parsing        |
| spaces        | int_parsing        |
| 123.4         | int_parsing        |
| 123,0         | int_parsing        |
| string(0)     | int_parsing        |
| string(8)     | int_parsing        |

@document @list
Scenario Outline: List documents when collection_id is correct
Given set request token from global param 'admin_token' 
  And set request param 'collection_id__eq' from value '<collection_id>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

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
Scenario Outline: List documents when document_name is correct
Given set request token from global param 'admin_token' 
  And set request param 'document_name__ilike' from value '<document_name>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

Examples:
| document_name |
| none          |
| tabs          |
| spaces        |
| 123           |
| string(0)     |
| string(8)     |

@document @list
Scenario Outline: List documents when document_size__ge is invalid
Given set request token from global param 'admin_token' 
  And set request param 'document_size__ge' from value '<document_size>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'document_size__ge'
  And error type is '<error_type>'

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
Given set request token from global param 'admin_token' 
  And set request param 'document_size__ge' from value '<document_size>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

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
Given set request token from global param 'admin_token' 
  And set request param 'document_size__le' from value '<document_size>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'document_size__le'
  And error type is '<error_type>'

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
Given set request token from global param 'admin_token' 
  And set request param 'document_size__le' from value '<document_size>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

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
Scenario Outline: List documents when document_mimetype is correct
Given set request token from global param 'admin_token' 
  And set request param 'document_mimetype__ilike' from value '<document_mimetype>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

Examples:
| document_mimetype |
| none              |
| tabs              |
| spaces            |
| 123               |
| string(0)         |
| string(8)         |

@document @list
Scenario Outline: List documents when revisions_count__ge is invalid
Given set request token from global param 'admin_token' 
  And set request param 'revisions_count__ge' from value '<revisions_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'revisions_count__ge'
  And error type is '<error_type>'

Examples:
| revisions_count | error_type  |
| tabs            | int_parsing |
| spaces          | int_parsing |
| 123.4           | int_parsing |
| 123,0           | int_parsing |
| string(0)       | int_parsing |
| string(8)       | int_parsing |

@document @list
Scenario Outline: List documents when revisions_count__ge is correct
Given set request token from global param 'admin_token' 
  And set request param 'revisions_count__ge' from value '<revisions_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

Examples:
| revisions_count |
| none            |
| 0               |
| 0.0             |
| -123            |
| -123.0          |
| +123            |
| +123.0          |

@document @list
Scenario Outline: List documents when revisions_count__le is invalid
Given set request token from global param 'admin_token' 
  And set request param 'revisions_count__le' from value '<revisions_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'revisions_count__le'
  And error type is '<error_type>'

Examples:
| revisions_count | error_type  |
| tabs            | int_parsing |
| spaces          | int_parsing |
| 123.4           | int_parsing |
| 123,0           | int_parsing |
| string(0)       | int_parsing |
| string(8)       | int_parsing |

@document @list
Scenario Outline: List documents when revisions_count__le is correct
Given set request token from global param 'admin_token' 
  And set request param 'revisions_count__le' from value '<revisions_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

Examples:
| revisions_count |
| none            |
| 0               |
| 0.0             |
| -123            |
| -123.0          |
| +123            |
| +123.0          |

@document @list
Scenario Outline: List documents when revisions_size__ge is invalid
Given set request token from global param 'admin_token' 
  And set request param 'revisions_size__ge' from value '<revisions_size>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'revisions_size__ge'
  And error type is '<error_type>'

Examples:
| revisions_size | error_type  |
| tabs           | int_parsing |
| spaces         | int_parsing |
| 123.4          | int_parsing |
| 123,0          | int_parsing |
| string(0)      | int_parsing |
| string(8)      | int_parsing |

@document @list
Scenario Outline: List documents when revisions_size__ge is correct
Given set request token from global param 'admin_token' 
  And set request param 'revisions_size__ge' from value '<revisions_size>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

Examples:
| revisions_size |
| none           |
| 0              |
| 0.0            |
| -123           |
| -123.0         |
| +123           |
| +123.0         |

@document @list
Scenario Outline: List documents when revisions_size__le is invalid
Given set request token from global param 'admin_token' 
  And set request param 'revisions_size__le' from value '<revisions_size>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'revisions_size__le'
  And error type is '<error_type>'

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
Given set request token from global param 'admin_token' 
  And set request param 'revisions_size__le' from value '<revisions_size>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

Examples:
| revisions_size |
| none           |
| 0              |
| 0.0            |
| -123           |
| -123.0         |
| +123           |
| +123.0         |

@document @list
Scenario Outline: List documents when comments_count__ge is invalid
Given set request token from global param 'admin_token' 
  And set request param 'comments_count__ge' from value '<comments_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'comments_count__ge'
  And error type is '<error_type>'

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
Given set request token from global param 'admin_token' 
  And set request param 'comments_count__ge' from value '<comments_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

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
Given set request token from global param 'admin_token' 
  And set request param 'comments_count__le' from value '<comments_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'comments_count__le'
  And error type is '<error_type>'

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
Given set request token from global param 'admin_token' 
  And set request param 'comments_count__le' from value '<comments_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

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
Scenario Outline: List documents when downloads_count__ge is invalid
Given set request token from global param 'admin_token' 
  And set request param 'downloads_count__ge' from value '<downloads_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'downloads_count__ge'
  And error type is '<error_type>'

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
Given set request token from global param 'admin_token' 
  And set request param 'downloads_count__ge' from value '<downloads_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

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
Given set request token from global param 'admin_token' 
  And set request param 'downloads_count__le' from value '<downloads_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'downloads_count__le'
  And error type is '<error_type>'

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
Given set request token from global param 'admin_token' 
  And set request param 'downloads_count__le' from value '<downloads_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

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
Scenario Outline: List documents when favorites_count__ge is invalid
Given set request token from global param 'admin_token' 
  And set request param 'favorites_count__ge' from value '<favorites_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'favorites_count__ge'
  And error type is '<error_type>'

Examples:
| favorites_count | error_type  |
| tabs            | int_parsing |
| spaces          | int_parsing |
| 123.4           | int_parsing |
| 123,0           | int_parsing |
| string(0)       | int_parsing |
| string(8)       | int_parsing |

@document @list
Scenario Outline: List documents when favorites_count__ge is correct
Given set request token from global param 'admin_token' 
  And set request param 'favorites_count__ge' from value '<favorites_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

Examples:
| favorites_count |
| none            |
| 0               |
| 0.0             |
| -123            |
| -123.0          |
| +123            |
| +123.0          |

@document @list
Scenario Outline: List documents when favorites_count__le is invalid
Given set request token from global param 'admin_token' 
  And set request param 'favorites_count__le' from value '<favorites_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '422'
  And error loc is 'favorites_count__le'
  And error type is '<error_type>'

Examples:
| favorites_count | error_type  |
| tabs            | int_parsing |
| spaces          | int_parsing |
| 123.4           | int_parsing |
| 123,0           | int_parsing |
| string(0)       | int_parsing |
| string(8)       | int_parsing |

@document @list
Scenario Outline: List documents when favorites_count__le is correct
Given set request token from global param 'admin_token' 
  And set request param 'favorites_count__le' from value '<favorites_count>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

Examples:
| favorites_count |
| none            |
| 0               |
| 0.0             |
| -123            |
| -123.0          |
| +123            |
| +123.0          |

@document @list
Scenario Outline: List documents when tag_value is correct
Given set request token from global param 'admin_token' 
  And set request param 'tag_value__eq' from value '<tag_value>'
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

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
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '<offset>'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
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

@document @list
Scenario Outline: List documents when offset is correct
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '<offset>'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

Examples:
| offset |
| 0      |
| 0.0    |
| 123    |
| 123.0  |
| +123   |

@document @list
Scenario Outline: List documents when limit is invalid
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '<limit>'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
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

@document @list
Scenario Outline: List documents when limit is correct
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '<limit>'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

Examples:
| limit |
| 1     |
| 123   |
| 123.0 |
| +123  |

@document @list
Scenario Outline: List documents when order_by is invalid
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value '<order_by>'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
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

@document @list
Scenario Outline: List documents when order_by is correct
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value '<order_by>'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

Examples:
| order_by          |
| id                |
| created_date      |
| updated_date      |
| user_id           |
| collection_id     |
| document_name     |
| document_size     |
| document_mimetype |
| revisions_count   |
| revisions_size    |
| comments_count    |
| downloads_count   |
| favorites_count   |

@document @list
Scenario Outline: List documents when order is invalid
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value '<order>'
 When send 'GET' request to url 'documents'
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

@document @list
Scenario Outline: List documents when order is correct
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value '<order>'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

Examples:
| order |
| asc   |
| desc  |
| rand  |

@document @list
Scenario: List documents when user is admin
    # lock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
    # list documents
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '503'
    # unlock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/unlock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
    # list documents
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

@document @list
Scenario: List documents when user is admin
Given set request token from global param 'admin_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

@document @list
Scenario: List documents when user is editor
Given set request token from global param 'editor_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

@document @list
Scenario: List documents when user is writer
Given set request token from global param 'writer_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

@document @list
Scenario: List documents when user is reader
Given set request token from global param 'reader_token' 
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '200'
  And response params contain 'documents'
  And response params contain 'documents_count'

@document @list
Scenario: List documents when token is missing
Given delete request token
  And set request param 'offset' from value '0'
  And set request param 'limit' from value '1'
  And set request param 'order_by' from value 'id'
  And set request param 'order' from value 'asc'
 When send 'GET' request to url 'documents'
 Then response code is '403'
