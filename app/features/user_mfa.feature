Feature: Retrieve MFA

Background: Authorize admin user
    # auth users
Given auth with user role 'admin'

@user @mfa
Scenario: Retrieve MFA when app is locked
    # register user
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
  And save response param 'user_id' to global param 'user_id'
  And save response param 'mfa_url' to global param 'mfa_url'
    # lock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/lock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'True'
    # retrieve MFA
 When send request to external url from global param 'mfa_url'
 Then response code is '503'
    # unlock app
Given set request token from global param 'admin_token' 
 When send 'GET' request to url 'system/unlock'
 Then response code is '200'
  And response params contain 'is_locked'
  And response param 'is_locked' equals 'False'
    # retrieve MFA
 When send request to external url from global param 'mfa_url'
 Then response code is '200'
  And response content is not empty
    # delete user
 When send 'GET' request to url 'user/:user_id'
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'

@user @mfa
Scenario: Retrieve MFA
    # register user
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
  And save response param 'user_id' to global param 'user_id'
  And save response param 'mfa_url' to global param 'mfa_url'
    # retrieve MFA
 When send request to external url from global param 'mfa_url'
 Then response code is '200'
  And response content is not empty
    # delete user
 When send 'GET' request to url 'user/:user_id'
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'user_id'
 When send 'DELETE' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'user_id'
