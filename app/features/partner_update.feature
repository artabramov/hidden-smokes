Feature: Update partner

Background: Auth users and create partner
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'

@partner @update
Scenario Outline: Update partner when partner_id not found
    # update partner
Given set request header token from global param 'editor_token' 
  And set request path param 'partner_id' from value '<partner_id>'
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '404'
  And error loc is 'path' and 'partner_id'
  And error type is 'resource_not_found'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_id  |
| -1         |
| 0          |
| 9999999999 |

@partner @update
Scenario Outline: Update partner when partner_name is invalid
    # update partner
Given set request header token from global param 'editor_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from value '<partner_name>'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '422'
  And error loc is 'body' and 'partner_name'
  And error type is '<error_type>'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_name | error_type       |
| none        | missing          |
| tabs        | string_too_short |
| spaces      | string_too_short |
| string(0)   | string_type      |
| string(257) | string_too_long  |

@partner @update
Scenario Outline: Update partner when partner_name is correct
    # update partner
Given set request header token from global param 'editor_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from value '<partner_name>'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_name |
| string(1)   |
| string(256) |

@partner @update
Scenario Outline: Update partner when partner_summary is invalid
    # update partner
Given set request header token from global param 'editor_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from value '<partner_summary>'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '422'
  And error loc is 'body' and 'partner_summary'
  And error type is '<error_type>'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_summary | error_type      |
| string(513)    | string_too_long |

@partner @update
Scenario Outline: Update partner when partner_summary is correct
    # update partner
Given set request header token from global param 'editor_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from value '<partner_summary>'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_summary |
| none           |
| tabs           |
| spaces         |
| string(0)      |
| string(1)      |
| string(512)    |

@partner @update
Scenario Outline: Update partner when partner_contacts is invalid
    # update partner
Given set request header token from global param 'editor_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from value '<partner_contacts>'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '422'
  And error loc is 'body' and 'partner_contacts'
  And error type is '<error_type>'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_contacts | error_type      |
| string(513)     | string_too_long |

@partner @update
Scenario Outline: Update partner when partner_contacts is correct
    # update partner
Given set request header token from global param 'editor_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from value '<partner_contacts>'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_contacts |
| none            |
| tabs            |
| spaces          |
| string(0)       |
| string(1)       |
| string(512)     |

@partner @update
Scenario Outline: Update partner when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token' 
 When send 'POST' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # update partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token' 
 When send 'DELETE' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # update partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @update
Scenario Outline: Update partner when user is admin
    # update partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @update
Scenario Outline: Update partner when user is editor
    # update partner
Given set request header token from global param 'editor_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @update
Scenario Outline: Update partner when user is writer
    # update partner
Given set request header token from global param 'writer_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @update
Scenario Outline: Update partner when user is reader
Given set request header token from global param 'reader_token' 
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

# @partner @update
Scenario Outline: Update partner when token is missing
Given delete request header token
  And set request path param 'partner_id' from global param 'partner_id'
  And set request body param 'partner_name' from fake 'partner_name'
  And set request body param 'partner_summary' from fake 'partner_summary'
  And set request body param 'partner_contacts' from fake 'partner_contacts'
 When send 'PUT' request to url 'partner/:partner_id'
 Then response code is '403'
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params
