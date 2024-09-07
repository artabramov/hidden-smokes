Feature: Select user

Background: Authorize users
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@user @select
Scenario: Select user when user_id not found
Given set request token from global param 'reader_token' 
  And set request placeholder 'user_id' from value '99999999'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '404'
  And error loc is 'user_id'
  And error type is 'resource_not_found'

@user @select
Scenario: Select user when select reader user
Given set request token from global param 'reader_token' 
  And set request placeholder 'user_id' from global param 'reader_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'last_login_date'
  And response params contain 'user_role'
  And response params contain 'is_active'
  And response params contain 'user_login'
  And response params contain 'first_name'
  And response params contain 'last_name'
  And response params contain 'user_signature'
  And response params contain 'user_contacts'
  And response params contain 'userpic_url'

@user @select
Scenario: Select user when select writer user
Given set request token from global param 'writer_token' 
  And set request placeholder 'user_id' from global param 'writer_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'last_login_date'
  And response params contain 'user_role'
  And response params contain 'is_active'
  And response params contain 'user_login'
  And response params contain 'first_name'
  And response params contain 'last_name'
  And response params contain 'user_signature'
  And response params contain 'user_contacts'
  And response params contain 'userpic_url'

@user @select
Scenario: Select user when select editor user
Given set request token from global param 'editor_token' 
  And set request placeholder 'user_id' from global param 'editor_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'last_login_date'
  And response params contain 'user_role'
  And response params contain 'is_active'
  And response params contain 'user_login'
  And response params contain 'first_name'
  And response params contain 'last_name'
  And response params contain 'user_signature'
  And response params contain 'user_contacts'
  And response params contain 'userpic_url'

@user @select
Scenario: Select user when select admin user
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'admin_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'last_login_date'
  And response params contain 'user_role'
  And response params contain 'is_active'
  And response params contain 'user_login'
  And response params contain 'first_name'
  And response params contain 'last_name'
  And response params contain 'user_signature'
  And response params contain 'user_contacts'
  And response params contain 'userpic_url'

@user @select
Scenario: Select user when user token is missing
Given delete request token 
  And set request placeholder 'user_id' from global param 'admin_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '403'
