Feature: Register user

Background: Auth users
    # auth users
Given auth with user role 'admin'

@user @register
Scenario Outline: Register user when user_login is invalid
    # register user
Given set request body param 'user_login' from value '<user_login>'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'body' and 'user_login'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| user_login | error_type              |
| none       | missing                 |
| tabs       | string_pattern_mismatch |
| spaces     | string_pattern_mismatch |
| string(0)  | string_pattern_mismatch |
| string(1)  | string_pattern_mismatch |
| string(41) | string_pattern_mismatch |
| john doe   | string_pattern_mismatch |
| john-doe   | string_pattern_mismatch |
| john_doe   | string_pattern_mismatch |
| иванов     | string_pattern_mismatch |

@user @register
Scenario Outline: Register user when user_login is correct
    # register user
Given set request body param 'user_login' from value '<user_login>'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'
  And response contains '3' params
  And save response param 'user_id' to global param 'user_id'
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

Examples:
| user_login |
| string(2)  |
| string(40) |

@user @register
Scenario Outline: Register user when user_password is invalid
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '<user_password>'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'body' and 'user_password'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| user_password | error_type       |
| none          | missing          |
| string(0)     | string_too_short |
| string(1)     | string_too_short |
| string(5)     | string_too_short |

@user @register
Scenario Outline: Register user when user_password is correct
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '<user_password>'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'
  And response contains '3' params
  And save response param 'user_id' to global param 'user_id'
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

Examples:
| user_password |
| tabs          |
| spaces        |
| string(6)     |

@user @register
Scenario Outline: Register user when first_name is invalid
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from value '<first_name>'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'body' and 'first_name'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| first_name | error_type       |
| none       | missing          |
| tabs       | string_too_short |
| spaces     | string_too_short |
| string(0)  | string_too_short |
| string(1)  | string_too_short |
| string(41) | string_too_long  |

@user @register
Scenario Outline: Register user when first_name is correct
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from value '<first_name>'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'
  And response contains '3' params
  And save response param 'user_id' to global param 'user_id'
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

Examples:
| first_name |
| string(2)  |
| string(40) |

@user @register
Scenario Outline: Register user when last_name is invalid
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from value '<last_name>'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'body' and 'last_name'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| last_name  | error_type       |
| none       | missing          |
| tabs       | string_too_short |
| spaces     | string_too_short |
| string(0)  | string_too_short |
| string(1)  | string_too_short |
| string(41) | string_too_long  |

@user @register
Scenario Outline: Register user when last_name is correct
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from value '<last_name>'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'
  And response contains '3' params
  And save response param 'user_id' to global param 'user_id'
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

Examples:
| last_name  |
| string(2)  |
| string(40) |

@user @register
Scenario Outline: Register user when user_signature is invalid
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from value '<user_signature>'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'body' and 'user_signature'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| user_signature | error_type      |
| string(41)     | string_too_long |

@user @register
Scenario Outline: Register user when user_signature is correct
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from value '<user_signature>'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'
  And response contains '3' params
  And save response param 'user_id' to global param 'user_id'
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

Examples:
| user_signature |
| none           |
| tabs           |
| spaces         |
| string(0)      |
| string(1)      |
| string(39)     |

@user @register
Scenario Outline: Register user when user_contacts is invalid
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from value '<user_contacts>'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'body' and 'user_contacts'
  And error type is '<error_type>'
  And response contains '1' params

Examples:
| user_contacts | error_type      |
| string(513)   | string_too_long |

@user @register
Scenario Outline: Register user when user_contacts is correct
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from value '<user_contacts>'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'
  And response contains '3' params
  And save response param 'user_id' to global param 'user_id'
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params

Examples:
| user_contacts |
| none          |
| tabs          |
| spaces        |
| string(0)     |
| string(1)     |
| string(512)   |

@user @register
Scenario: Register user when protected mode is enabled
Given auth with user role 'admin'
    # enable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '1'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'True'
  And response contains '1' params
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '423'
    # disable protected mode
Given set request header token from global param 'admin_token'
  And set request body param 'is_protected' from value '0'
 When send 'PUT' request to url 'protected'
 Then response code is '200'
  And response params contain 'is_protected'
  And response param 'is_protected' equals 'False'
  And response contains '1' params
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'
  And response contains '3' params
  And save response param 'user_id' to global param 'user_id'
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

@user @register
Scenario: Register user
    # register user
Given set request body param 'user_login' from fake 'user_login'
  And set request body param 'user_password' from value '123456'
  And set request body param 'first_name' from fake 'first_name'
  And set request body param 'last_name' from fake 'last_name'
  And set request body param 'user_signature' from fake 'user_signature'
  And set request body param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'
  And response contains '3' params
  And save response param 'user_id' to global param 'user_id'
    # delete user
Given set request header token from global param 'admin_token' 
  And set request path param 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
  And response contains '1' params
