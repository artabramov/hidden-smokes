Feature: List mediafiles

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@mediafile @list
Scenario Outline: List mediafiles when collection_id is invalid
    # list mediafiles
Given set request header token from global param 'admin_token'
  And set request query param 'collection_id__eq' from value '<collection_id>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
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

@mediafile @list
Scenario Outline: List mediafiles when collection_id is correct
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'collection_id__eq' from value '<collection_id>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '200'
  And response params contain 'mediafiles'
  And response params contain 'mediafiles_count'
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

@mediafile @list
Scenario Outline: List mediafiles when comments_count__ge is invalid
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'comments_count__ge' from value '<comments_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '422'
  And error loc is 'query' and 'comments_count__ge'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| comments_count | error_type  |
| tabs           | int_parsing |
| spaces         | int_parsing |
| 123.4          | int_parsing |
| 123,0          | int_parsing |
| string(0)      | int_parsing |
| string(8)      | int_parsing |

@mediafile @list
Scenario Outline: List mediafiles when comments_count__ge is correct
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'comments_count__ge' from value '<comments_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '200'
  And response params contain 'mediafiles'
  And response params contain 'mediafiles_count'
  And response contains '2' params

Examples:
| comments_count |
| none           |
| 0              |
| 0.0            |
| -123           |
| -123.0         |
| +123           |
| +123.0         |

@mediafile @list
Scenario Outline: List mediafiles when comments_count__le is invalid
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'comments_count__le' from value '<comments_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '422'
  And error loc is 'query' and 'comments_count__le'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| comments_count | error_type  |
| tabs           | int_parsing |
| spaces         | int_parsing |
| 123.4          | int_parsing |
| 123,0          | int_parsing |
| string(0)      | int_parsing |
| string(8)      | int_parsing |

@mediafile @list
Scenario Outline: List mediafiles when comments_count__le is correct
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'comments_count__le' from value '<comments_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '200'
  And response params contain 'mediafiles'
  And response params contain 'mediafiles_count'
  And response contains '2' params

Examples:
| comments_count |
| none           |
| 0              |
| 0.0            |
| -123           |
| -123.0         |
| +123           |
| +123.0         |

@mediafile @list
Scenario Outline: List mediafiles when revisions_count__ge is invalid
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_count__ge' from value '<revisions_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '422'
  And error loc is 'query' and 'revisions_count__ge'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| revisions_count | error_type  |
| tabs          | int_parsing |
| spaces        | int_parsing |
| 123.4         | int_parsing |
| 123,0         | int_parsing |
| string(0)     | int_parsing |
| string(8)     | int_parsing |

@mediafile @list
Scenario Outline: List mediafiles when revisions_count__ge is correct
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_count__ge' from value '<revisions_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '200'
  And response params contain 'mediafiles'
  And response params contain 'mediafiles_count'
  And response contains '2' params

Examples:
| revisions_count |
| none          |
| 0             |
| 0.0           |
| -123          |
| -123.0        |
| +123          |
| +123.0        |

@mediafile @list
Scenario Outline: List mediafiles when revisions_count__le is invalid
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_count__le' from value '<revisions_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '422'
  And error loc is 'query' and 'revisions_count__le'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| revisions_count | error_type  |
| tabs          | int_parsing |
| spaces        | int_parsing |
| 123.4         | int_parsing |
| 123,0         | int_parsing |
| string(0)     | int_parsing |
| string(8)     | int_parsing |

@mediafile @list
Scenario Outline: List mediafiles when revisions_count__le is correct
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_count__le' from value '<revisions_count>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '200'
  And response params contain 'mediafiles'
  And response params contain 'mediafiles_count'
  And response contains '2' params

Examples:
| revisions_count |
| none          |
| 0             |
| 0.0           |
| -123          |
| -123.0        |
| +123          |
| +123.0        |

@mediafile @list
Scenario Outline: List mediafiles when revisions_size__ge is invalid
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_size__ge' from value '<revisions_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '422'
  And error loc is 'query' and 'revisions_size__ge'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| revisions_size | error_type  |
| tabs         | int_parsing |
| spaces       | int_parsing |
| 123.4        | int_parsing |
| 123,0        | int_parsing |
| string(0)    | int_parsing |
| string(8)    | int_parsing |

@mediafile @list
Scenario Outline: List mediafiles when revisions_size__ge is correct
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_size__ge' from value '<revisions_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '200'
  And response params contain 'mediafiles'
  And response params contain 'mediafiles_count'
  And response contains '2' params

Examples:
| revisions_size |
| none         |
| 0            |
| 0.0          |
| -123         |
| -123.0       |
| +123         |
| +123.0       |

@mediafile @list
Scenario Outline: List mediafiles when revisions_size__le is invalid
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_size__le' from value '<revisions_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '422'
  And error loc is 'query' and 'revisions_size__le'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| revisions_size | error_type  |
| tabs         | int_parsing |
| spaces       | int_parsing |
| 123.4        | int_parsing |
| 123,0        | int_parsing |
| string(0)    | int_parsing |
| string(8)    | int_parsing |

@mediafile @list
Scenario Outline: List mediafiles when revisions_size__le is correct
    # list mediafiles
Given set request header token from global param 'admin_token' 
  And set request query param 'revisions_size__le' from value '<revisions_size>'
  And set request query param 'offset' from value '0'
  And set request query param 'limit' from value '1'
  And set request query param 'order_by' from value 'id'
  And set request query param 'order' from value 'asc'
 When send 'GET' request to url 'mediafiles'
 Then response code is '200'
  And response params contain 'mediafiles'
  And response params contain 'mediafiles_count'
  And response contains '2' params

Examples:
| revisions_size |
| none         |
| 0            |
| 0.0          |
| -123         |
| -123.0       |
| +123         |
| +123.0       |

# @mediafile @list
# Scenario Outline: List mediafiles when downloads_count__ge is invalid
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'downloads_count__ge' from value '<downloads_count>'
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '422'
#   And error loc is 'downloads_count__ge'
#   And error type is '<error_type>'

# Examples:
# | downloads_count | error_type  |
# | tabs            | int_parsing |
# | spaces          | int_parsing |
# | 123.4           | int_parsing |
# | 123,0           | int_parsing |
# | string(0)       | int_parsing |
# | string(8)       | int_parsing |

# @mediafile @list
# Scenario Outline: List mediafiles when downloads_count__ge is correct
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'downloads_count__ge' from value '<downloads_count>'
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# Examples:
# | downloads_count |
# | none            |
# | 0               |
# | 0.0             |
# | -123            |
# | -123.0          |
# | +123            |
# | +123.0          |

# @mediafile @list
# Scenario Outline: List mediafiles when downloads_count__le is invalid
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'downloads_count__le' from value '<downloads_count>'
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '422'
#   And error loc is 'downloads_count__le'
#   And error type is '<error_type>'

# Examples:
# | downloads_count | error_type  |
# | tabs            | int_parsing |
# | spaces          | int_parsing |
# | 123.4           | int_parsing |
# | 123,0           | int_parsing |
# | string(0)       | int_parsing |
# | string(8)       | int_parsing |

# @mediafile @list
# Scenario Outline: List mediafiles when downloads_count__le is correct
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'downloads_count__le' from value '<downloads_count>'
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# Examples:
# | downloads_count |
# | none            |
# | 0               |
# | 0.0             |
# | -123            |
# | -123.0          |
# | +123            |
# | +123.0          |

# @mediafile @list
# Scenario Outline: List mediafiles when favorites_count__ge is invalid
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'favorites_count__ge' from value '<favorites_count>'
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '422'
#   And error loc is 'favorites_count__ge'
#   And error type is '<error_type>'

# Examples:
# | favorites_count | error_type  |
# | tabs            | int_parsing |
# | spaces          | int_parsing |
# | 123.4           | int_parsing |
# | 123,0           | int_parsing |
# | string(0)       | int_parsing |
# | string(8)       | int_parsing |

# @mediafile @list
# Scenario Outline: List mediafiles when favorites_count__ge is correct
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'favorites_count__ge' from value '<favorites_count>'
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# Examples:
# | favorites_count |
# | none            |
# | 0               |
# | 0.0             |
# | -123            |
# | -123.0          |
# | +123            |
# | +123.0          |

# @mediafile @list
# Scenario Outline: List mediafiles when favorites_count__le is invalid
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'favorites_count__le' from value '<favorites_count>'
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '422'
#   And error loc is 'favorites_count__le'
#   And error type is '<error_type>'

# Examples:
# | favorites_count | error_type  |
# | tabs            | int_parsing |
# | spaces          | int_parsing |
# | 123.4           | int_parsing |
# | 123,0           | int_parsing |
# | string(0)       | int_parsing |
# | string(8)       | int_parsing |

# @mediafile @list
# Scenario Outline: List mediafiles when favorites_count__le is correct
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'favorites_count__le' from value '<favorites_count>'
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# Examples:
# | favorites_count |
# | none            |
# | 0               |
# | 0.0             |
# | -123            |
# | -123.0          |
# | +123            |
# | +123.0          |

# @mediafile @list
# Scenario Outline: List mediafiles when tag_value is correct
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'tag_value__eq' from value '<tag_value>'
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# Examples:
# | tag_value |
# | none      |
# | tabs      |
# | spaces    |
# | 0         |
# | 123       |
# | string(0) |
# | string(8) |

# @mediafile @list
# Scenario Outline: List mediafiles when offset is invalid
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '<offset>'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '422'
#   And error loc is 'offset'
#   And error type is '<error_type>'

# Examples:
# | offset    | error_type         |
# | none      | missing            |
# | tabs      | int_parsing        |
# | spaces    | int_parsing        |
# | 123.4     | int_parsing        |
# | 123,0     | int_parsing        |
# | -123      | greater_than_equal |
# | string(0) | int_parsing        |
# | string(8) | int_parsing        |

# @mediafile @list
# Scenario Outline: List mediafiles when offset is correct
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '<offset>'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# Examples:
# | offset |
# | 0      |
# | 0.0    |
# | 123    |
# | 123.0  |
# | +123   |

# @mediafile @list
# Scenario Outline: List mediafiles when limit is invalid
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '<limit>'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '422'
#   And error loc is 'limit'
#   And error type is '<error_type>'

# Examples:
# | limit     | error_type         |
# | none      | missing            |
# | tabs      | int_parsing        |
# | spaces    | int_parsing        |
# | 0         | greater_than_equal |
# | 0.0       | greater_than_equal |
# | 123.4     | int_parsing        |
# | 123,0     | int_parsing        |
# | -123      | greater_than_equal |
# | string(0) | int_parsing        |
# | string(8) | int_parsing        |

# @mediafile @list
# Scenario Outline: List mediafiles when limit is correct
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '<limit>'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# Examples:
# | limit |
# | 1     |
# | 123   |
# | 123.0 |
# | +123  |

# @mediafile @list
# Scenario Outline: List mediafiles when order_by is invalid
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value '<order_by>'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '422'
#   And error loc is 'order_by'
#   And error type is '<error_type>'

# Examples:
# | order_by  | error_type    |
# | none      | missing       |
# | tabs      | literal_error |
# | spaces    | literal_error |
# | 0         | literal_error |
# | 123       | literal_error |
# | string(8) | literal_error |

# @mediafile @list
# Scenario Outline: List mediafiles when order_by is correct
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value '<order_by>'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# Examples:
# | order_by          |
# | id                |
# | created_date      |
# | updated_date      |
# | user_id           |
# | collection_id     |
# | mediafile_name     |
# | revisions_count   |
# | revisions_size    |
# | comments_count    |
# | downloads_count   |
# | favorites_count   |

# @mediafile @list
# Scenario Outline: List mediafiles when order is invalid
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value '<order>'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '422'
#   And error loc is 'order'
#   And error type is '<error_type>'

# Examples:
# | order  | error_type    |
# | none   | missing       |
# | tabs   | literal_error |
# | spaces | literal_error |
# | 0      | literal_error |
# | 123    | literal_error |
# | ASC    | literal_error |
# | DESC   | literal_error |

# @mediafile @list
# Scenario Outline: List mediafiles when order is correct
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value '<order>'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# Examples:
# | order |
# | asc   |
# | desc  |
# | rand  |

# @mediafile @list
# Scenario: List mediafiles when user is admin
#     # lock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/lock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'True'
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '503'
#     # unlock app
# Given set request header token from global param 'admin_token' 
#  When send 'GET' request to url 'system/unlock'
#  Then response code is '200'
#   And response params contain 'is_locked'
#   And response param 'is_locked' equals 'False'
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# @mediafile @list
# Scenario: List mediafiles when user is admin
#     # list mediafiles
# Given set request header token from global param 'admin_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# @mediafile @list
# Scenario: List mediafiles when user is editor
#     # list mediafiles
# Given set request header token from global param 'editor_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# @mediafile @list
# Scenario: List mediafiles when user is writer
#     # list mediafiles
# Given set request header token from global param 'writer_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# @mediafile @list
# Scenario: List mediafiles when user is reader
#     # list mediafiles
# Given set request header token from global param 'reader_token' 
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '200'
#   And response params contain 'mediafiles'
#   And response params contain 'mediafiles_count'
#   And response contains '2' params

# @mediafile @list
# Scenario: List mediafiles when token is missing
#     # list mediafiles
# Given delete request header token
#   And set request query param 'offset' from value '0'
#   And set request query param 'limit' from value '1'
#   And set request query param 'order_by' from value 'id'
#   And set request query param 'order' from value 'asc'
#  When send 'GET' request to url 'mediafiles'
#  Then response code is '403'
