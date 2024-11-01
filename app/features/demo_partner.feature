Feature: Create demo partner

Background: Authorize users
Given auth with user role 'admin'

@partner @demo
Scenario: Create demo partner
Given set request header token from global param 'admin_token' 
  And set request body param 'is_locked' from value '0'
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
