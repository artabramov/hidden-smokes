Feature: User select

Background: Auth
Given auth with user role 'admin'
  And auth with user role 'editor'
  And auth with user role 'writer'
  And auth with user role 'reader'

@user @select
Scenario: Select admin user
Given set request token from global param 'admin_token' 
  And set request placeholder 'user_id' from global param 'admin_id'
 When send 'GET' request to url 'user/:user_id'
 Then response code is '200'
  And response params contain 'id'
  And response params contain 'created_date'
  And response params contain 'updated_date'
  And response params contain 'logged_date'
  And response params contain 'user_role'
  And response params contain 'is_active'
  And response params contain 'user_login'
  And response params contain 'first_name'
  And response params contain 'last_name'
  And response params contain 'user_signature'
  And response params contain 'user_contacts'
  And response params contain 'userpic_url'
