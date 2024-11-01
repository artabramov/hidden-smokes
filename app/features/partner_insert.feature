Feature: Insert partner

Background: Auth users
    # auth users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@partner @insert
Scenario Outline: Insert partner when partner_name is invalid
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from value '<partner_name>'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '422'
  And error loc is 'body' and 'partner_name'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| partner_name | error_type       |
| none        | missing          |
| tabs        | string_too_short |
| spaces      | string_too_short |
| string(0)   | string_type      |
| string(257) | string_too_long  |

@partner @insert
Scenario Outline: Insert partner when partner_name is correct
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
  And set request body param 'partner_name' from value '<partner_name>'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'
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

@partner @insert
Scenario Outline: Insert partner when partner_type is invalid
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from value '<partner_type>'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '422'
  And error loc is 'body' and 'partner_type'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| partner_type | error_type      |
| string(257)  | string_too_long |

@partner @insert
Scenario Outline: Insert partner when partner_type is correct
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from value '<partner_type>'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_type |
| none         |
| tabs         |
| spaces       |
| string(0)    |
| string(1)    |
| string(256)  |

@partner @insert
Scenario Outline: Insert partner when partner_region is invalid
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from value '<partner_region>'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '422'
  And error loc is 'body' and 'partner_region'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| partner_region | error_type      |
| string(257)    | string_too_long |

@partner @insert
Scenario Outline: Insert partner when partner_region is correct
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from value '<partner_region>'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_region |
| none           |
| tabs           |
| spaces         |
| string(0)      |
| string(1)      |
| string(256)    |

@partner @insert
Scenario Outline: Insert partner when partner_website is invalid
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from value '<partner_website>'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '422'
  And error loc is 'body' and 'partner_website'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| partner_website | error_type      |
| string(257)     | string_too_long |

@partner @insert
Scenario Outline: Insert partner when partner_website is correct
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from value '<partner_website>'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_website |
| none            |
| tabs            |
| spaces          |
| string(0)       |
| string(1)       |
| string(256)     |

@partner @insert
Scenario Outline: Insert partner when partner_contacts is invalid
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from value '<partner_contacts>'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '422'
  And error loc is 'body' and 'partner_contacts'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| partner_contacts | error_type      |
| string(513)      | string_too_long |

@partner @insert
Scenario Outline: Insert partner when partner_contacts is correct
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from value '<partner_contacts>'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

Examples:
| partner_contacts |
| none             |
| tabs             |
| spaces           |
| string(0)        |
| string(1)        |
| string(512)      |


@partner @insert
Scenario Outline: Insert partner when partner_summary is invalid
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from value '<partner_summary>'
 When send 'POST' request to url 'partner'
 Then response code is '422'
  And error loc is 'body' and 'partner_summary'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| partner_summary | error_type      |
| string(513)    | string_too_long |

@partner @insert
Scenario Outline: Insert partner when partner_summary is correct
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from value '<partner_summary>'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'
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


@partner @insert
Scenario: Insert partner when protected mode is enabled
    # enable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '1'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '0'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'

@partner @insert
Scenario: Insert partner when user is admin
    # insert partner
Given set request header token from global param 'admin_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @insert
Scenario: Insert partner when user is editor
    # insert partner
Given set request header token from global param 'editor_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @insert
Scenario: Insert partner when user is writer
    # insert partner
Given set request header token from global param 'writer_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '201'
  And response params contain 'partner_id'
  And response contains '1' params
  And save response param 'partner_id' to global param 'partner_id'
    # delete partner
Given set request header token from global param 'admin_token' 
  And set request path param 'partner_id' from global param 'partner_id'
 When send 'DELETE' request to url 'partner/:partner_id'
 Then response code is '200'
  And response params contain 'partner_id'
  And response contains '1' params

@partner @insert
Scenario: Insert partner when user is reader
    # insert partner
Given set request header token from global param 'reader_token' 
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '403'
  And error loc is 'header' and 'user_token'
  And error type is 'user_role_rejected'
  And response contains '1' params

@partner @insert
Scenario: Insert partner when token is missing
    # insert partner
Given delete request header token
  And set request body param 'is_locked' from value '0'
  And set request body param 'partner_name' from fake 'company'
  And set request body param 'partner_type' from fake 'catch_phrase'
  And set request body param 'partner_region' from fake 'country'
  And set request body param 'partner_website' from fake 'domain_name'
  And set request body param 'partner_contacts' from fake 'company_email'
  And set request body param 'partner_summary' from fake 'partner_summary'
 When send 'POST' request to url 'partner'
 Then response code is '403'
