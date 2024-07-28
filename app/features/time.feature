Feature: Get time

@time
Scenario: Get time
When send 'GET' request to url 'time'
Then response code is '200'
