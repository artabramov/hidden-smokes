Feature: Register user

@user @register
Scenario Outline: Register user when user_login is invalid
Given set request param 'user_login' from value '<user_login>'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_signature' from fake 'user_signature'
  And set request param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'user_login'
  And error type is '<error_type>'

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
Scenario Outline: Register user when user_password is invalid
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '<user_password>'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_signature' from fake 'user_signature'
  And set request param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'user_password'
  And error type is '<error_type>'

Examples:
| user_password | error_type  |
| none          | missing     |
| tabs          | value_error |
| spaces        | value_error |
| string(0)     | too_short   |
| string(1)     | too_short   |
| string(5)     | too_short   |

@user @register
Scenario Outline: Register user when user_password is correct
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '<user_password>'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_signature' from fake 'user_signature'
  And set request param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'

Examples:
| user_password |
| string(6)     |

@user @register
Scenario Outline: Register user when first_name is invalid
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from value '<first_name>'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_signature' from fake 'user_signature'
  And set request param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'first_name'
  And error type is '<error_type>'

Examples:
| first_name | error_type       |
| none       | missing          |
| tabs       | value_error      |
| spaces     | value_error      |
| string(0)  | string_too_short |
| string(1)  | string_too_short |
| string(41) | string_too_long  |

@user @register
Scenario Outline: Register user when first_name is correct
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from value '<first_name>'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_signature' from fake 'user_signature'
  And set request param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'

Examples:
| first_name |
| string(2)  |
| string(40) |

@user @register
Scenario Outline: Register user when last_name is invalid
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from value '<last_name>'
  And set request param 'user_signature' from fake 'user_signature'
  And set request param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'last_name'
  And error type is '<error_type>'

Examples:
| last_name  | error_type       |
| none       | missing          |
| tabs       | value_error      |
| spaces     | value_error      |
| string(0)  | string_too_short |
| string(1)  | string_too_short |
| string(41) | string_too_long  |

@user @register
Scenario Outline: Register user when last_name is correct
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from value '<last_name>'
  And set request param 'user_signature' from fake 'user_signature'
  And set request param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'

Examples:
| last_name  |
| string(2)  |
| string(40) |

@user @register
Scenario Outline: Register user when user_signature is invalid
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_signature' from value '<user_signature>'
  And set request param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'user_signature'
  And error type is '<error_type>'

Examples:
| user_signature | error_type      |
| string(41)     | string_too_long |

@user @register
Scenario Outline: Register user when user_signature is correct
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_signature' from value '<user_signature>'
  And set request param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'

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
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_signature' from fake 'user_signature'
  And set request param 'user_contacts' from value '<user_contacts>'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'user_contacts'
  And error type is '<error_type>'

Examples:
| user_contacts | error_type      |
| string(513)   | string_too_long |

@user @register
Scenario Outline: Register user when user_contacts is correct
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_signature' from fake 'user_signature'
  And set request param 'user_contacts' from value '<user_contacts>'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'

Examples:
| user_contacts |
| none          |
| tabs          |
| spaces        |
| string(0)     |
| string(1)     |
| string(512)   |

@user @register
Scenario: Register user
Given set request param 'user_login' from fake 'user_login'
  And set request param 'user_password' from value '123456'
  And set request param 'first_name' from fake 'first_name'
  And set request param 'last_name' from fake 'last_name'
  And set request param 'user_signature' from fake 'user_signature'
  And set request param 'user_contacts' from fake 'user_contacts'
 When send 'POST' request to url 'user'
 Then response code is '201'
  And response params contain 'user_id'
  And response params contain 'mfa_secret'
  And response params contain 'mfa_url'
