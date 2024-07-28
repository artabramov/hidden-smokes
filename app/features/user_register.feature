Feature: User register

@user @register
Scenario Outline: When user_login is invalid
Given set request param 'user_login' from value '<user_login>'
  And set request param 'user_password' from value 'abcdef'
  And set request param 'first_name' from value 'John'
  And set request param 'last_name' from value 'Doe'
 When send 'POST' request to url 'user'
 Then response code is '422'
  And error loc is 'user_login'
  And error type is '<error_type>'

Examples: invalid user_login
| user_login                                | error_type              |
| None                                      | missing                 |
| empty                                     | string_pattern_mismatch |
| whitespaces                               | string_pattern_mismatch |
| a                                         | string_pattern_mismatch |
| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | string_pattern_mismatch |
| john doe                                  | string_pattern_mismatch |
| john-doe                                  | string_pattern_mismatch |
| john_doe                                  | string_pattern_mismatch |
| иванов                                    | string_pattern_mismatch |

# @user @register
# Scenario Outline: When user_login is invalid
# Given set request param 'user_login' from value '<invalid user_login>'
#   And set request param 'user_password' from value '123456'
#   And set request param 'first_name' from value 'John'
#   And set request param 'last_name' from value 'Doe'
#  When send 'POST' request to url 'user'
#  Then response code is '422'
#   And response params contain 'detail'
#   And error type is 'fuck'

# Examples: invalid user_login
# | invalid user_login                        |
# | None                                      |
# | empty                                     |
# | whitespaces                               |
# | a                                         |
# | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
# | john doe                                  |
# | john-doe                                  |
# | john_doe                                  |
# | иванов                                    |

# @user @register
# Scenario Outline: When user_password is invalid
# Given set request param 'user_login' from value 'johndoe'
#   And set request param 'user_password' from value '<invalid user_password>'
#   And set request param 'first_name' from value 'John'
#   And set request param 'last_name' from value 'Doe'
#  When send 'POST' request to url 'user'
#  Then response code is '422'
#   And response params contain 'detail'

# Examples: invalid user_password
# | invalid user_password |
# | None                  |
# | empty                 |
# | whitespaces           |
# | a                     |
# | aaaaa                 |

# @user @register
# Scenario Outline: When first_name is invalid
# Given set request param 'user_login' from value 'johndoe'
#   And set request param 'user_password' from value '123456'
#   And set request param 'first_name' from value '<invalid first_name>'
#   And set request param 'last_name' from value 'Doe'
#  When send 'POST' request to url 'user'
#  Then response code is '422'
#   And response params contain 'detail'

# Examples: invalid first_name
# | invalid first_name    |
# | None                  |
# | empty                 |
# | whitespaces           |
# | a                     |
# | aaaaa                 |
